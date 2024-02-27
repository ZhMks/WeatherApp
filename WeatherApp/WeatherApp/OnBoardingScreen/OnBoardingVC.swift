
import UIKit
import CoreLocation

protocol IOnBoardingVC: AnyObject {
    func requestAuthorisation()
    func pushGeoVC()
}

class OnboardingViewController: UIViewController, IOnBoardingVC  {

    private let coreDataService: CoreDataService = CoreDataService.shared

    private let networkService: NetworkService

    private let coredataModelService: CoreDataModelService

    private let mainView: OnboardingView


    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()


    init(mainView: OnboardingView, networkService: NetworkService, coreDataModelService: CoreDataModelService) {
        self.mainView = mainView
        self.networkService = networkService
        self.coredataModelService = coreDataModelService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
        guard let array = coredataModelService.modelArray else  { return }
        if !array.isEmpty {
            checkModelsArray()
        }
    }

    private func layout() {
        view.addSubview(mainView)
        mainView.loginVC = self
        mainView.frame = view.frame
    }

    func requestAuthorisation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func fetchData(with lat: String, lon: String) {

        networkService.fetchData(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let fetchedData):

                coredataModelService.saveModelToCoreData(networkModel: fetchedData)

                guard let modelsArray = coredataModelService.modelArray else { return }
                guard let firstModel = modelsArray.first else { return }

                DispatchQueue.main.async {[weak self] in

                    guard let self else { return }

                    let pageViewController = PageViewController(coreDataModelService: coredataModelService)

                    pageViewController.initialCreation()

                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(pageViewController)
                }

            case .failure(let failure):
                print(failure.description)
            }
        }
    }

    func pushGeoVC() {
        let networkService = NetworkService()
        let geoLoactionService = GeoLocationService()
        let geoView = GeoLocationView()
        let geoVC = GeoLocationViewController(geoView: geoView, geoLocationService: geoLoactionService, networkService: networkService, coredataModelService: coredataModelService)
        navigationController?.pushViewController(geoVC, animated: true)
    }

    private func checkModelsArray() {
        let pageViewController = PageViewController(coreDataModelService: coredataModelService)
        pageViewController.initialCreation()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(pageViewController)
    }
}


extension OnboardingViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first?.coordinate else { return }

        let lat = String(location.latitude)
        let lon = String(location.longitude)

        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            fetchData(with: lat, lon: lon)
        case .denied:
            manager.stopUpdatingLocation()
        case .notDetermined:
            manager.stopUpdatingLocation()
        case .restricted:
            manager.stopUpdatingLocation()
        @unknown default:
            assertionFailure("Error in LocationManager")
        }
    }

}
