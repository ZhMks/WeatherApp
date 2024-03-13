
import UIKit
import CoreLocation

protocol IOnBoardingVC: AnyObject {
    func requestAuthorisation()
    func pushGeoVC()
}

class OnboardingViewController: UIViewController, IOnBoardingVC  {

    private let coreDataService: ForecastDataService = ForecastDataService.shared

    private let networkService: NetworkService

    private let mainForecastModelService: MainForecastModelService

    private let mainView: OnboardingView

    private let geoDataService: GeoDataModelService


    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .white
        return activityIndicator
    }()


    init(mainView: OnboardingView, networkService: NetworkService, coreDataModelService: MainForecastModelService, geoDataService: GeoDataModelService) {
        self.mainView = mainView
        self.networkService = networkService
        self.mainForecastModelService = coreDataModelService
        self.geoDataService = geoDataService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleCoreDataSaveCompleted),
                                               name: NSNotification.Name("coreDataSaved"),
                                               object: nil)
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
        mainForecastModelService.removeAllData()
        checkModelsArray()
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

    private func initialFetchData(with lat: String, lon: String) {

        networkService.fetchData(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }

            switch result {

            case .success(let fetchedData):

                mainForecastModelService.saveModelToCoreData(networkModel: fetchedData) { [weak self]  result in

                    guard let self else { return }

                    switch result {

                    case .success(let success):

                        DispatchQueue.main.async { [weak self] in

                            guard let self else { return }

                            let pageViewController = PageViewController(coreDataModelService: mainForecastModelService, geoDataService: geoDataService)

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

    private func fetchData(with lat: String, lon: String) {

        networkService.fetchData(lat: lat, lon: lon) { [weak self] result in

            guard let self else { return }

            switch result {

            case .success(let fetchedData):

                DispatchQueue.main.async { [weak self] in

                    guard let self else { return }

                    mainForecastModelService.saveModelToCoreData(networkModel: fetchedData) { _ in

                        switch result {
                        case .success(_):
                           break
                        case .failure(let failure):
                            print("\(failure.description)")
                        }
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
        let geoVC = GeoLocationViewController(geoView: geoView, geoLocationService: geoLoactionService, networkService: networkService, coredataModelService: mainForecastModelService, geoDataService: geoDataService)
        navigationController?.pushViewController(geoVC, animated: true)
    }

    private func checkModelsArray() {
        view.addSubview(activityIndicator)
        guard let geoModels = geoDataService.modelArray else { return }
        if !geoModels.isEmpty {
            for model in geoModels {
                activityIndicator.startAnimating()
                fetchData(with: model.lat!, lon: model.lon!)
            }
            NotificationCenter.default.post(name: NSNotification.Name("coreDataSaved"), object: nil)
        }
    }

    @objc private func handleCoreDataSaveCompleted() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            activityIndicator.stopAnimating()
            let pageViewController = PageViewController(coreDataModelService: mainForecastModelService, geoDataService: geoDataService)
            pageViewController.initialFetch()
            print(pageViewController.viewControllersArray?.count)

            NotificationCenter.default.removeObserver(self)
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(pageViewController)
        }
    }
}


extension OnboardingViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first?.coordinate else { return }

        let lat = String(location.latitude)
        let lon = String(location.longitude)

        geoDataService.saveModelToCoreData(lat: lat, lon: lon)

        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let modelArray = geoDataService.modelArray {
                for model in modelArray {
                    self.initialFetchData(with: model.lat!, lon: model.lon!)
                }
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
