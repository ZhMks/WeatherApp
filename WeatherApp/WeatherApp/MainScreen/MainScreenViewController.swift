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

    var mainModel: [MainForecastsModels]

    private let mainScreenView = MainScreenView(frame: .zero)

    init(coreDataModelService: CoreDataModelService, mainModel: [MainForecastsModels]) {
        self.mainModel = mainModel
        self.coreDataModelService = coreDataModelService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        updateDataSource()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
            layout()
    }

    private func layout() {
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
        let forecastModelService = ForecastModelService(coreDataModel: (mainModel.first)!)
        let hoursModelService = HoursModelService(coreDataModel: (forecastModelService.forecastModel?.first)!)
        let mainTableViewDataSource = DataSourceForMainScreen()
        let mainCollectionDataSource = DataSourceForMainCollectionCell()

        guard let forecastArray = forecastModelService.forecastModel else { return }

        mainCollectionDataSource.updateData(data: hoursModelService.hoursArray)
        mainTableViewDataSource.updateData(data: forecastArray)

        mainScreenView.updateViewWith(tbDataSource: mainTableViewDataSource,
                                      collectionDataSource: mainCollectionDataSource,
                                      factModel: forecastArray, hourModel: hoursModelService.hoursArray)

    }

    func pushTwentyFourVc() {
        guard let mainModel = coreDataModelService.modelArray?.first else { return }
        let forecastModelService = ForecastModelService(coreDataModel: mainModel)
        guard let forecastArray = forecastModelService.forecastModel else { return }
        let twentyFourVC = DetailTwentyFourViewController()
        twentyFourVC.updateView(with: forecastArray)
        navigationController?.pushViewController(twentyFourVC, animated: true)
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc() {
        let detailDayVC = DetailDayViewController()
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {}
}
