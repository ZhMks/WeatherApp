//
//  DetailTwentyFourViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

class DetailTwentyFourViewController: UIViewController {

    private let detailView = DetailTwentyFourView()
    private let tbDataSource: TableDataSourceForTwentyFour
    private let collectionDataSource: DataSourceForHumidityCollection

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    init(tbDataSource: TableDataSourceForTwentyFour, collectionSource: DataSourceForHumidityCollection) {
        self.tbDataSource = tbDataSource
        self.collectionDataSource = collectionSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        view.addSubview(detailView)
        let backButton = UIBarButtonItem()
        backButton.title = "Прогноз на 24 часа"
        backButton.tintColor = .gray
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let safeArea = view.safeAreaLayoutGuide
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(safeArea)
        }
    }

    func updateView(with forecast: ForecastModel, mainModel: MainForecastsModels, hours: [HourModel]) {
        let hourModelService = HoursModelService(coreDataModel: forecast)
        let hourArray = hourModelService.hoursArray
        detailView.updateView(with: hourArray, mainModel: mainModel, dataSource: self.tbDataSource, collectionSource: self.collectionDataSource)
    }

}
