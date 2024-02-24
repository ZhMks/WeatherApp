
import UIKit
import CoreLocation

protocol IOnBoardingVC: AnyObject {
    func requestAuthorisation()
}

class OnboardingViewController: UIViewController, IOnBoardingVC  {

    private let coreDataService: CoreDataService = CoreDataService.shared

    private let networkService: NetworkService

    private let coredataModelService = CoreDataModelService()

    private let mainView: OnboardingView


    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()


    init(mainView: OnboardingView, networkService: NetworkService) {
        self.mainView = mainView
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
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

    private func fetchData(with lat: Double, lon: Double) {
        networkService.fetchData(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let fetchedData):
                
               coredataModelService.saveModelToCoreData(networkModel: fetchedData)

                guard let modelsArray = coredataModelService.modelArray else { return }

                DispatchQueue.main.async {[weak self] in
                    guard let self else { return }

                    let forecastModelService = ForecastModelService(coreDataModel: (modelsArray.first)!)
                    let hoursModelService = HoursModelService(coreDataModel: (forecastModelService.forecastModel?.first)!)

                    guard var forecastsArray = forecastModelService.forecastModel else { return }

                    let hoursArray = hoursModelService.hoursArray

                    let mainViewController = MainScreenViewController(coreDataModelService: coredataModelService,
                                                                      mainModel: modelsArray,
                                                                      forecastsModels: forecastsArray,
                                                                      hoursModels: hoursArray)

                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainViewController)
                }

            case .failure(let failure):
                print(failure.description)
            }
        }
    }
}


extension OnboardingViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first?.coordinate else { return }

        let lat = location.latitude
        let lon = location.longitude

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
