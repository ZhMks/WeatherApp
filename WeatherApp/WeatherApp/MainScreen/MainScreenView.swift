//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import SnapKit
import UIKit

class MainScreenView: UIView {
    
    private var forecastModelArray: [ForecastModel]?
    private var hoursModelArray: [HourModel]?
    weak var mainScreenVC: IMainScreenController?

    private let mainWeatherView = WeatherView()

    private lazy var detailsTwentyFourHours: UIButton = {
        let details = UIButton(type: .system)
        details.translatesAutoresizingMaskIntoConstraints = false
        details.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 16)
        let attributedString = NSMutableAttributedString(string: "Подробнее на 24 часа")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))
        details.setTitleColor(.black, for: .normal)
        details.setAttributedTitle(attributedString, for: .normal)
        details.addTarget(self, action: #selector(tapOnTwentyFourButton(_:)), for: .touchUpInside)
        return details
    }()

    private lazy var tableViewTitle: UILabel = {
        let tableViewTitle = UILabel()
        tableViewTitle.translatesAutoresizingMaskIntoConstraints = false
        tableViewTitle.font = UIFont(name: "Rubik-medium", size: 14)
        tableViewTitle.text = "Ежедневный прогноз"
        return tableViewTitle
    }()

    private lazy var weatherByTimeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.delegate = self
        weatherCollectionView.allowsSelection = false
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        return weatherCollectionView
    }()

     private lazy var everydayForecastTableView: UITableView = {
        let everydayTableView = UITableView(frame: .zero, style: .insetGrouped)
        everydayTableView.translatesAutoresizingMaskIntoConstraints = false
        everydayTableView.delegate = self
        everydayTableView.register(EverydayForecastTableViewCell.self,
                                   forCellReuseIdentifier: EverydayForecastTableViewCell.id)
        everydayTableView.backgroundColor = .clear
        return everydayTableView
    }()

    // MARK: -LIFECYCLE

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -LAYOUT

    private func layout() {
        addSubview(mainWeatherView)
        addSubview(detailsTwentyFourHours)
        addSubview(weatherByTimeCollectionView)
        addSubview(everydayForecastTableView)
        addSubview(tableViewTitle)

        let safeArea = safeAreaLayoutGuide
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false

        mainWeatherView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-450)
        }

        detailsTwentyFourHours.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherView.snp.bottom).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-15)
        }

        weatherByTimeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(detailsTwentyFourHours.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(16)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-5)
            make.height.equalTo(120)
        }

        tableViewTitle.snp.makeConstraints { make in
            make.top.equalTo(weatherByTimeCollectionView.snp.bottom).offset(5)
            make.leading.equalTo(safeArea.snp.leading).offset(16)
        }

        everydayForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewTitle.snp.bottom)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom)
        }
    }

    // MARK: -FUNCS
    
    @objc private func tapOnTwentyFourButton(_ sender: UIButton) {
        mainScreenVC?.pushTwentyFourVc()
    }

    func updateViewWith(tbDataSource: UITableViewDataSource, collectionDataSource: UICollectionViewDataSource, forecastModels: [ForecastModel], hourModels: [HourModel], factModel: ForecastModel) {

        self.weatherByTimeCollectionView.dataSource = collectionDataSource
        self.weatherByTimeCollectionView.reloadData()

        self.everydayForecastTableView.dataSource = tbDataSource
        self.everydayForecastTableView.reloadData()

        self.forecastModelArray = forecastModels
        self.hoursModelArray = hourModels

        mainWeatherView.updateView(fact: factModel, hourModel: hourModels)
        scrollToCurrentHour()
    }

// Функция для скролла ячейки к нужному времени.
   func scrollToCurrentHour() {
        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        var timeString = dateFormatter.string(from: currentTime)
        var components = timeString.components(separatedBy: ":")

        guard let currentHour = components.first else { return }

       if let value = UserDefaults.standard.value(forKey: "time") as? String {
           switch value {
           case "12":
               dateFormatter.locale = Locale(identifier: "en_GB")
               dateFormatter.dateFormat = "h:mm a"
               timeString = dateFormatter.string(from: currentTime)
               components = timeString.components(separatedBy: ":")
               guard let currentHour = components.first else { return }
               if let hoursModelArray = hoursModelArray {
                   for (index, value) in hoursModelArray.enumerated() {
                       if value.hour!.contains(currentHour) {
                           let indexPath = IndexPath(item: index, section: 0)
                           weatherByTimeCollectionView.performBatchUpdates({
                               weatherByTimeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                               let cell = weatherByTimeCollectionView.cellForItem(at: indexPath) as? WeatherCollectionViewCell
                               cell?.isSelected = true
                               cell?.performUpdate()
                           })
                       }
                   }
               }
           case "24":
               if let hoursModelArray = hoursModelArray {
                   for (index, value) in hoursModelArray.enumerated() {
                       if value.hour!.contains(currentHour) {
                           let indexPath = IndexPath(item: index, section: 0)
                           weatherByTimeCollectionView.performBatchUpdates({
                               weatherByTimeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

                               let cell = weatherByTimeCollectionView.cellForItem(at: indexPath) as? WeatherCollectionViewCell
                               cell?.isSelected = true
                               cell?.performUpdate()
                           })
                       }
                   }
               }
           default: break
           }
       }
    }

    func reloadData() {
        everydayForecastTableView.reloadData()
    }
}

// MARK: -COLLECTIONDELEGATE

extension MainScreenView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = weatherByTimeCollectionView.cellForItem(at: indexPath)! as? DetailDayCollectionViewCell
        selectedCell?.performUpdate()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 48, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
}


// MARK: -TABLEVIEWDELEGATE

extension MainScreenView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let forecastArray = forecastModelArray else { return }
        let forecast = forecastArray[indexPath.row]
        let hourModelService = HoursModelService(coreDataModel: forecast)
        let hoursArray = hourModelService.hoursArray
        let index = indexPath.row
        mainScreenVC?.pushDayNightVc(forecast: forecast, hoursArray: hoursArray, index: index)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return CGFloat.leastNormalMagnitude
        }

        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }

}
