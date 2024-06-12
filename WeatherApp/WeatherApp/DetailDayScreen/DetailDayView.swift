//
//  DetailDayView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

final class DetailDayView: UIView {

    private var forecastModel: ForecastModel?
    private var hours: [HourModel]?
    private var mainModel: MainForecastsModels?
    private var forecastArray: [ForecastModel]?
    private var dayNightTableViewSource: UITableViewDataSource?
    private var dateCollectionSource: UICollectionViewDataSource?
    private let contentView = ContentView(frame: .zero)


    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.showsVerticalScrollIndicator = true
        mainScrollView.isScrollEnabled = true
        mainScrollView.contentSize = CGSize(width: mainScrollView.bounds.width, height: mainScrollView.bounds.height)
        return mainScrollView
    }()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.text = "Ulyanovsk, Russia"
        return cityLabel
    }()

    private lazy var dateCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        dateCollectionView.delegate = self
        dateCollectionView.register(DetailDayCollectionViewCell.self, forCellWithReuseIdentifier: DetailDayCollectionViewCell.id)
        return dateCollectionView
    }()
  
    // MARK: -LIFECYCLE

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -FUNCS
    
    func updateView(dataSource: ForecastModel, hours: [HourModel], mainModel: MainForecastsModels, forecastArray: [ForecastModel], dayNightTableViewSource: UITableViewDataSource, dateCollectionSource: UICollectionViewDataSource) {
        self.forecastModel = dataSource
        self.hours = hours
        self.mainModel = mainModel
        self.forecastArray = forecastArray
        self.dayNightTableViewSource = dayNightTableViewSource
        self.dateCollectionSource = dateCollectionSource
        contentView.configureTableView(dataSource: dayNightTableViewSource)
        contentView.updateDataForView(forecast: forecastModel!)
        configureCollectionView(dataSource: dateCollectionSource)
        cityLabel.text = "\(mainModel.country!), \(mainModel.locality!)"
    }

    func configureCollectionView(dataSource: UICollectionViewDataSource) {
        self.dateCollectionView.dataSource = dataSource
        self.dateCollectionView.reloadData()
    }
}

// MARK: -COLLECTIONDELEGATE

extension DetailDayView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let forecastArray = forecastArray else { return }
        let forecast = forecastArray[indexPath.row]
        let hourModelService = HoursModelService(coreDataModel: forecast)
        let hoursArray = hourModelService.hoursArray
        (dayNightTableViewSource as? TableDataSourceForDayNightScreen)?.updateData(data: hoursArray, forecastModel: forecast)
        let selectedCell = dateCollectionView.cellForItem(at: indexPath)! as? DetailDayCollectionViewCell
        selectedCell!.performUpdate()
        contentView.updateDataForView(forecast: forecast)
        contentView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = dateCollectionView.cellForItem(at: indexPath)! as? DetailDayCollectionViewCell
        selectedCell!.performUpdate()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 90, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: -LAYOUT

extension DetailDayView {
    private func createViews() {
        addSubview(dateCollectionView)
        addSubview(cityLabel)
        addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
    }

    private func layout() {

        createViews()

        contentView.translatesAutoresizingMaskIntoConstraints = false

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-204)
        }

        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.height.equalTo(65)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }

        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.snp.top)
            make.bottom.equalTo(mainScrollView.snp.bottom)
            make.leading.equalTo(mainScrollView.snp.leading)
            make.trailing.equalTo(mainScrollView.snp.trailing)
            make.width.equalTo(mainScrollView.snp.width)
        }
    }
}
