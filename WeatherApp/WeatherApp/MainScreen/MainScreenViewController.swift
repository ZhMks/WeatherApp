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

    private var mainModel: [MainForecastsModels]
    private var forecastsModels: [ForecastModel]
    private let hoursModels: [HourModel]

    private let mainScreenView = MainScreenView(frame: .zero)

    init(coreDataModelService: CoreDataModelService,
         mainModel: [MainForecastsModels],
         forecastsModels: [ForecastModel],
         hoursModels: [HourModel])
    {
        self.mainModel = mainModel
        self.forecastsModels = forecastsModels
        print(self.forecastsModels.count)
        self.hoursModels = hoursModels
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
    }

    private func layout() {
        updateDataSource()
        view.addSubview(mainScreenView)
        updateViewController()
        mainScreenView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        mainScreenView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }

    private func updateViewController() {
        mainScreenView.mainScreenVC = self

        navigationItem.title = "\((mainModel.first?.name)!)"

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Burger"), style: .plain, target: self, action: #selector(burgerButtonTapped(_:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Landmark"), style: .plain, target: self, action: #selector(rightButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    private func updateDataSource() {
        let forecastModelService = ForecastModelService(coreDataModel: mainModel.first!)

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var stringDate = dateFormatter.string(from: currentDate)

        for (index, element) in forecastsModels.enumerated() {
            if element.date! != stringDate {
                forecastModelService.delete(item: element)
            } else {
                break
            }
        }

        forecastModelService.fetchData()

        guard let convertedModels = forecastModelService.forecastModel else { return }

        self.forecastsModels = convertedModels

        let mainTableViewDataSource = DataSourceForMainScreen()
        let mainCollectionDataSource = DataSourceForMainCollectionCell()

        mainCollectionDataSource.updateData(data: hoursModels)
        mainTableViewDataSource.updateData(data: forecastsModels)

        mainScreenView.updateViewWith(tbDataSource: mainTableViewDataSource,
                                      collectionDataSource: mainCollectionDataSource,
                                      factModel: forecastsModels, hourModel: hoursModels)

    }

    func pushTwentyFourVc() {
        let twentyFourVC = DetailTwentyFourViewController()
        twentyFourVC.updateView(with: forecastsModels)
        navigationController?.pushViewController(twentyFourVC, animated: true)
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc() {
        let detailDayVC = DetailDayViewController()
        detailDayVC.updateDataForView(data: forecastsModels)
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {}

    @objc private func startUpdate(_ notification: NotificationCenter) {
        updateDataSource()
    }
}
