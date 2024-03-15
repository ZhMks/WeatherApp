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
    func pushDayNightVc(forecast: ForecastModel, hoursArray: [HourModel], index: Int)
}

class MainScreenViewController: UIViewController, IMainScreenController {

    private let coreDataModelService: MainForecastModelService

    var mainModel: MainForecastsModels?
    private var forecastsModel: ForecastModel
    private var forecastModeslArray: [ForecastModel]
    private let hoursModels: [HourModel]
    private let tableViewDataSource: DataSourceForMainScreen
    private let collectionViewDataSource: DataSourceForMainCollectionCell
    private let geoDataService: GeoDataModelService

    weak var mainPageViewController: iPageViewController?

    private let mainScreenView = MainScreenView(frame: .zero)

    init(coreDataModelService: MainForecastModelService, forecastsModel: ForecastModel, hoursModels: [HourModel],
         forecastModelsArray: [ForecastModel], mainModel: MainForecastsModels, tableViewDataSource: DataSourceForMainScreen, collectionViewDataSource: DataSourceForMainCollectionCell, geoDataService: GeoDataModelService) {
        self.forecastsModel = forecastsModel
        self.forecastModeslArray = forecastModelsArray
        self.hoursModels = hoursModels
        self.mainModel = mainModel
        self.coreDataModelService = coreDataModelService
        self.tableViewDataSource = tableViewDataSource
        self.collectionViewDataSource = collectionViewDataSource
        self.geoDataService = geoDataService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startUpdate),
                                               name: NSNotification.Name("performUpdate"),
                                               object: nil)
        mainScreenView.scrollToCurrentHour()
        updateDataSource()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
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

        mainScreenView.updateViewWith(tbDataSource: tableViewDataSource,
                                      collectionDataSource: collectionViewDataSource,
                                      forecastModels: forecastModeslArray,
                                      hourModels: hoursModels,
                                      factModel: forecastsModel)
    }

    func pushTwentyFourVc() {
        let tableViewDataSource = TableDataSourceForTwentyFour()
        let collectionSource = DataSourceForHumidityCollection()
        tableViewDataSource.updateData(data: hoursModels)

        var xValues = [HourModel]()

        for index in stride(from: 0, to: hoursModels.count, by: 3) {
            let valueToAppend = hoursModels[index]
            xValues.append(valueToAppend)
        }
        collectionSource.updateData(data: xValues)
        
        let twentyFourVC = DetailTwentyFourViewController(tbDataSource: tableViewDataSource, collectionSource: collectionSource)
        twentyFourVC.updateView(with: forecastsModel, mainModel: mainModel!, hours: hoursModels)
        navigationController?.pushViewController(twentyFourVC, animated: true)
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        guard let mainModel = mainModel else { return }
        let settingsVC = SettingsViewController(mainModel: mainModel)
        settingsVC.modalPresentationStyle = .fullScreen
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc(forecast: ForecastModel, hoursArray: [HourModel], index: Int) {
        let detailDayVC = DetailDayViewController()
        let tableViewDataSource = TableDataSourceForDayNightScreen()
        let collectionViewDataSource = CollectionDataSourceFordayNightScreen()
        tableViewDataSource.updateData(data: hoursArray, forecastModel: forecast)
        collectionViewDataSource.updateData(data: forecastModeslArray, index: index)
        detailDayVC.updateDataForView(forecastModel: forecast, mainModel: mainModel!, hoursArray: hoursArray, forecastArray: forecastModeslArray, tableSource: tableViewDataSource, collectionSource: collectionViewDataSource)
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {
        let geoView = GeoLocationView()
        let geoLocationService = GeoLocationService()
        let networkService = NetworkService()
        let geoLocationViewController = GeoLocationViewController(geoView: geoView, geoLocationService: geoLocationService, networkService: networkService, coredataModelService: coreDataModelService, geoDataService: geoDataService)
        geoLocationViewController.mainPageViewController = self.mainPageViewController
        navigationController?.pushViewController(geoLocationViewController, animated: true)
    }

    @objc private func startUpdate() {
        updateDataSource()
    }

    private func checkConvertedValues() {
        if let tempValue = UserDefaults.standard.value(forKey: "temperature") as? String {
            ValueConverter.shared.convertTempValues()
        }

        if let speedValue = UserDefaults.standard.value(forKey: "distance") as? String  {
            ValueConverter.shared.convertSpeedValues()
        }

        if let timeValue = UserDefaults.standard.value(forKey: "time") as? String {
            ValueConverter.shared.convertHourFormat()
        }
    }
}
