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

    var tableViewDataSource: DataSourceForMainScreen?
    var collectionViewDataSource: DataSourceForMainCollectionCell?

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    @objc private func tapOnTwentyFourButton(_ sender: UIButton) {
        mainScreenVC?.pushTwentyFourVc()
    }

    func configureTableView(dataSource: UITableViewDataSource) {
        self.everydayForecastTableView.dataSource = dataSource
        self.everydayForecastTableView.reloadData()
    }

    func configureCollectionView(dataSource: UICollectionViewDataSource) {
        self.weatherByTimeCollectionView.dataSource = dataSource
        self.weatherByTimeCollectionView.reloadData()
    }

    func updateViewWith(tbDataSource: UITableViewDataSource, collectionDataSource: UICollectionViewDataSource, forecastModels: [ForecastModel], hourModels: [HourModel], factModel: ForecastModel) {

        configureTableView(dataSource: tbDataSource)
        configureCollectionView(dataSource: collectionDataSource)
        
        self.forecastModelArray = forecastModels
        self.hoursModelArray = hourModels

        mainWeatherView.updateView(fact: factModel, hourModel: hourModels)
    }

   func scrollToCurrentHour() {

        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeString = dateFormatter.string(from: currentTime)
        let components = timeString.components(separatedBy: ":")

        guard let currentHour = components.first else { return }

        if let hoursModelArray = hoursModelArray {
            for (index, value) in hoursModelArray.enumerated() {
                if value.hour!.contains(currentHour) {
                    let indexPath = IndexPath(item: index, section: 0)
                    weatherByTimeCollectionView.performBatchUpdates({
                        weatherByTimeCollectionView.scrollToItem(at: indexPath,
                                                                 at: .centeredHorizontally,
                                                                 animated: true) },
                                                                    completion: nil)
                }
            }
        }
    }
}

// MARK: -COLLECTIONDELEGATE

extension MainScreenView: UICollectionViewDelegateFlowLayout {

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
        mainScreenVC?.pushDayNightVc()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return CGFloat.leastNormalMagnitude
        }

        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }

}
