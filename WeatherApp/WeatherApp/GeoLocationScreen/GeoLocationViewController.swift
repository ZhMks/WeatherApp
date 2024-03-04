//
//  GeoLocationViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 25.02.2024.
//

import UIKit
import SnapKit

protocol IGeoLocationVC {
    func startFetchingGeo(string: String)
    func checkModelsArray(string: String)
    func initialFetchWith(string: String, controller: PageViewController)
}

class GeoLocationViewController: UIViewController, IGeoLocationVC {

    private let networkService: NetworkService

    weak var mainPageViewController: iPageViewController?

    private let geoLocationService: GeoLocationService

    private let geoView: GeoLocationView

    private let coreDataModelService: MainForecastModelService

    private let geoDataService: GeoDataModelService

    init(geoView: GeoLocationView, geoLocationService: GeoLocationService, networkService: NetworkService, coredataModelService: MainForecastModelService, geoDataService: GeoDataModelService) {
        self.geoView = geoView
        self.geoLocationService = geoLocationService
        self.networkService = networkService
        self.coreDataModelService = coredataModelService
        self.geoDataService = geoDataService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }


    private func layout() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = .gray
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.addSubview(geoView)
        geoView.translatesAutoresizingMaskIntoConstraints = false
        geoView.geoVC = self
        geoView.updateData(coreData: coreDataModelService)

        geoView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func startFetchingGeo(string: String) {
        geoLocationService.getLocationWith(string: string) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                geoDataService.saveModelToCoreData(lat: success.lat, lon: success.lon)
                networkService.fetchData(lat: success.lat, lon: success.lon) { [weak self] result in
                    guard self != nil else { return }

                    switch result {
                    case .success(let success):

                        self?.coreDataModelService.saveModelToCoreData(networkModel: success) { [weak self] result in
                            guard let self else { return }
                            switch result {
                            case .success(let success):
                                mainPageViewController?.createViewControllerWithModel(model: success)
                                DispatchQueue.main.async { [weak self] in
                                    self?.navigationController?.popViewController(animated: true)
                                }
                            case .failure(let failure):
                                let uiAlert = UIAlertController(title: "Ошибка", message: "\(failure.description)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Отмена", style: .cancel) { action in
                                    if action.isEnabled {
                                        DispatchQueue.main.async { [weak self] in
                                            self?.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                }
                                uiAlert.addAction(action)
                                DispatchQueue.main.async {
                                    self.navigationController?.present(uiAlert, animated: true)
                                }
                            }
                        }
                    case .failure(let failure):
                        print("\(failure)")
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func initialFetchWith(string: String, controller: PageViewController) {
        geoLocationService.getLocationWith(string: string) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                geoDataService.saveModelToCoreData(lat: success.lat, lon: success.lon)
                networkService.fetchData(lat: success.lat, lon: success.lon) { [weak self] result in
                    guard self != nil else { return }

                    switch result {
                    case .success(let success):

                        self?.coreDataModelService.saveModelToCoreData(networkModel: success) { [weak self] result in
                            guard let self else { return }
                            switch result {
                            case .success(_):
                                DispatchQueue.main.async { [weak self] in
                                    controller.initialFetch()
                                    self?.navigationController?.popViewController(animated: true)
                                }
                            case .failure(let failure):
                                let uiAlert = UIAlertController(title: "Ошибка", message: "\(failure.description)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Отмена", style: .cancel) { action in
                                    if action.isEnabled {
                                        DispatchQueue.main.async { [weak self] in
                                            self?.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                }
                                uiAlert.addAction(action)
                                DispatchQueue.main.async {
                                    self.navigationController?.present(uiAlert, animated: true)
                                }
                            }
                        }
                    case .failure(let failure):
                        print("\(failure)")
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func checkModelsArray(string: String) {
        if let modelsArray = coreDataModelService.modelArray {
            if modelsArray.isEmpty {
                let pageViewController = PageViewController(coreDataModelService: coreDataModelService, geoDataService: geoDataService)
                initialFetchWith(string: string, controller: pageViewController)
                DispatchQueue.main.async {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(pageViewController)
                }
            } else {
                startFetchingGeo(string: string)
            }
        }

    }
}
