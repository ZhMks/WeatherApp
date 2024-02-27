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
}

class GeoLocationViewController: UIViewController, IGeoLocationVC {

    private let networkService: NetworkService

    weak var mainPageViewController: iPageViewController?

    private let geoLocationService: GeoLocationService

    private let geoView: GeoLocationView

    private let coreDataModelService: CoreDataModelService

    init(geoView: GeoLocationView, geoLocationService: GeoLocationService, networkService: NetworkService, coredataModelService: CoreDataModelService) {
        self.geoView = geoView
        self.geoLocationService = geoLocationService
        self.networkService = networkService
        self.coreDataModelService = coredataModelService
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

        geoView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func startFetchingGeo(string: String) {
        geoLocationService.getLocationWith(string: string) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                networkService.fetchData(lat: success.lat, lon: success.lon) { [weak self] result in
                    guard self != nil else { return }
                    switch result {
                    case .success(let success):
                        print(success.info.tzInfo.name)

                        self?.coreDataModelService.saveModelToCoreData(networkModel: success)

                        self?.mainPageViewController?.addToPageViewControllerWith(name: success.info.tzInfo.name)
                        DispatchQueue.main.async {
                            self?.navigationController?.popViewController(animated: true)
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

}
