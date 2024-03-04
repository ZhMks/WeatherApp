
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

    private var lat: String?
    private var lon: String?


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

                coredataModelService.saveModelToCoreData(networkModel: fetchedData) { [weak self]  result in

                    guard let self else { return }

                    switch result {
                    case .success(let success):

                        DispatchQueue.main.async { [weak self] in

                            guard let self else { return }

                            let pageViewController = PageViewController(coreDataModelService: coredataModelService)

                            pageViewController.createViewControllerWithModel(model: success)

                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(pageViewController)
                        }
                    case .failure(_):
                        let uiAlert = UIAlertController(title: "Ошибка", message: "Невозможно определить локацию", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Отмена", style: .cancel) { action in
                            if action.isEnabled {
                                self.navigationController?.dismiss(animated: true)
                            }
                        }
                        uiAlert.addAction(action)
                        navigationController?.present(uiAlert, animated: true)
                    }
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
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            coredataModelService.removeAllData()
            if let latValue = UserDefaults.standard.value(forKey: "latitude") as? String, let lonValue = UserDefaults.standard.value(forKey: "longitude") as? String {
                print(latValue)
                print(lonValue)
                self.fetchData(with: latValue, lon: lonValue)
            }
        }
    }
}


extension OnboardingViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first?.coordinate else { return }

        self.lat = String(location.latitude)
        self.lon = String(location.longitude)

        UserDefaults.standard.setValue(lat, forKey: "latitude")
        UserDefaults.standard.setValue(lon, forKey: "longitude")
        UserDefaults.standard.synchronize()

        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let lat = self.lat, let lon = self.lon {
                fetchData(with: lat, lon: lon)
            }
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
