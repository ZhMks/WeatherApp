//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

protocol IMainScreenController: AnyObject {
    func pushTwentyFourVc()
    func pushDayNightVc()
}

class MainScreenViewController: UIViewController, IMainScreenController {

    private let coreDataModelService: CoreDataModelService

    var mainModel: MainForecastsModels?
    private var forecastsModel: ForecastModel
    private var forecastModeslArray: [ForecastModel]
    private let hoursModels: [HourModel]

    weak var mainPageViewController: iPageViewController?

    private let mainScreenView = MainScreenView(frame: .zero)

    init(coreDataModelService: CoreDataModelService, forecastsModel: ForecastModel, hoursModels: [HourModel],
         forecastModelsArray: [ForecastModel], mainModel: MainForecastsModels) {
        self.forecastsModel = forecastsModel
        self.forecastModeslArray = forecastModelsArray
        self.hoursModels = hoursModels
        self.mainModel = mainModel
        self.coreDataModelService = coreDataModelService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //    NotificationCenter.default.addObserver(self, selector: #selector(startUpdate(_:)), name: "sceneDidBecomeActive", object: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        updateDataSource()
    }

    func updateNavigationItems(model: MainForecastsModels) {
        navigationItem.title = "\((model.locality)!), \((model.country)!)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Burger"), style: .plain, target: self, action: #selector(burgerButtonTapped(_:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Landmark"), style: .plain, target: self, action: #selector(rightButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    private func layout() {
        view.addSubview(mainScreenView)
        mainScreenView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        mainScreenView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }

    private func updateDataSource() {
        mainScreenView.mainScreenVC = self

        let mainTableViewDataSource = DataSourceForMainScreen()
        let mainCollectionDataSource = DataSourceForMainCollectionCell()

//        mainCollectionDataSource.updateData(data: hoursModels)
//        mainTableViewDataSource.updateData(data: forecas)

        mainScreenView.updateViewWith(tbDataSource: mainTableViewDataSource,
                                      collectionDataSource: mainCollectionDataSource,
                                      forecastModels: forecastModeslArray, hourModels: hoursModels, factModel: forecastsModel)

    }

    func pushTwentyFourVc() {
        let twentyFourVC = DetailTwentyFourViewController()
        twentyFourVC.updateView(with: forecastsModel, mainModel: mainModel!)
        navigationController?.pushViewController(twentyFourVC, animated: true)
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        guard let mainModel = mainModel else { return }
        let settingsVC = SettingsViewController(mainModel: mainModel)
        settingsVC.modalPresentationStyle = .fullScreen
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc() {
        let detailDayVC = DetailDayViewController()
        detailDayVC.updateDataForView(forecastModel: forecastsModel, mainModel: mainModel!, hoursArray: hoursModels, forecastArray: forecastModeslArray)
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {
        let geoView = GeoLocationView()
        let geoLocationService = GeoLocationService()
        let networkService = NetworkService()
        let geoLocationViewController = GeoLocationViewController(geoView: geoView, geoLocationService: geoLocationService, networkService: networkService, coredataModelService: coreDataModelService)
        geoLocationViewController.mainPageViewController = self.mainPageViewController
        navigationController?.pushViewController(geoLocationViewController, animated: true)
    }

    @objc private func startUpdate(_ notification: NotificationCenter) {
        updateDataSource()
    }
}
