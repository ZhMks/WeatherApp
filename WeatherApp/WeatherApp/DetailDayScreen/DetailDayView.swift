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

    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.showsVerticalScrollIndicator = true
        mainScrollView.isScrollEnabled = true

        return mainScrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemMint
        return contentView
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
        dateCollectionView.dataSource = self
        dateCollectionView.register(DetailDayCollectionViewCell.self, forCellWithReuseIdentifier: DetailDayCollectionViewCell.id)
        return dateCollectionView
    }()

    private lazy var dayNightTableView: UITableView = {
        let dayNightTableView = UITableView(frame: .zero, style: .insetGrouped)
        dayNightTableView.translatesAutoresizingMaskIntoConstraints = false
        dayNightTableView.delegate = self
        dayNightTableView.dataSource = self
        dayNightTableView.register(DetailDayTableViewCell.self, forCellReuseIdentifier: DetailDayTableViewCell.id)
        dayNightTableView.backgroundColor = .systemBackground
        return dayNightTableView
    }()

    private lazy var sunAndMoonLabel: UILabel = {
        let sunAndMoonLabel = UILabel()
        sunAndMoonLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        sunAndMoonLabel.text = "Солнце и Луна"
        sunAndMoonLabel.textColor = .black
        sunAndMoonLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunAndMoonLabel
    }()

    private lazy var sunImage: UIImageView = {
        let sunImage = UIImageView()
        sunImage.image = UIImage(named: "UfLight")
        sunImage.translatesAutoresizingMaskIntoConstraints = false
        return sunImage
    }()

    private lazy var moonImage: UIImageView = {
        let moonImage = UIImageView()
        moonImage.image = UIImage(named: "MoonImage")
        moonImage.translatesAutoresizingMaskIntoConstraints = false
        return moonImage
    }()

    private lazy var moonStatusLabel: UILabel = {
        let moonStatusLabel = UILabel()
        moonStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        moonStatusLabel.text = "Полнолуние"
        moonStatusLabel.textColor = .black
        return moonStatusLabel
    }()

    private lazy var lightDayTimeLabel: UILabel = {
        let lightDayTimeLabel = UILabel()
        lightDayTimeLabel.text = "14ч 57м"
        lightDayTimeLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        lightDayTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return lightDayTimeLabel
    }()

    private lazy var sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.text = "Восход"
        sunriseLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        sunriseLabel.textColor = .gray
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunriseLabel
    }()

    private lazy var sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        sunsetLabel.text = "Заход"
        sunsetLabel.textColor = .gray
        sunsetLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunsetLabel
    }()

    private lazy var sunriseTime: UILabel = {
        let sunriseTime = UILabel()
        sunriseTime.text = "5:47"
        sunriseTime.font = UIFont(name: "Rubik-Regular", size: 14)
        sunriseTime.translatesAutoresizingMaskIntoConstraints = false
        return sunriseTime
    }()

    private lazy var sunsetTime: UILabel = {
        let sunsetTime = UILabel()
        sunsetTime.text = "20:20"
        sunsetTime.font = UIFont(name: "Rubik-Regular", size: 14)
        sunsetTime.translatesAutoresizingMaskIntoConstraints = false
        return sunsetTime
    }()

    private lazy var airConditionLabel: UILabel = {
        let airConditionLabel = UILabel()
        airConditionLabel.text = "Качество воздуха"
        airConditionLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        airConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        return airConditionLabel
    }()

    private lazy var airConditionNumber: UILabel = {
        let airCondtionNumber = UILabel()
        airCondtionNumber.font = UIFont(name: "Rubik-Regular", size: 30)
        airCondtionNumber.text = "42"
        airCondtionNumber.translatesAutoresizingMaskIntoConstraints = false
        return airCondtionNumber
    }()

    private lazy var airConditionButton: UIButton = {
        let airCondtionButton = UIButton(type: .system)
        airCondtionButton.isEnabled = false
        airCondtionButton.setTitle("Хорошо", for: .normal)
        airCondtionButton.setTitleColor(.white, for: .normal)
        airCondtionButton.backgroundColor = .systemGreen
        airCondtionButton.translatesAutoresizingMaskIntoConstraints = false
        airCondtionButton.layer.cornerRadius = 8
        return airCondtionButton
    }()

    private lazy var airConditionText: UILabel = {
        let airConditionText = UILabel()
        airConditionText.translatesAutoresizingMaskIntoConstraints = false
        airConditionText.font = UIFont(name: "Rubik-Regular", size: 14)
        airConditionText.textAlignment = .left
        airConditionText.numberOfLines = 0
        airConditionText.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        airConditionText.text = """
        Качество воздуха считается 
        удовлетворительным и загрязнения
        воздуха представляются незначительными
        в пределах нормы
"""
        return airConditionText
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        addSubview(mainScrollView)
        addSubview(dateCollectionView)
        addSubview(cityLabel)
        addSubview(contentView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(dayNightTableView)
        contentView.addSubview(sunAndMoonLabel)
        contentView.addSubview(sunImage)
        contentView.addSubview(moonImage)
        contentView.addSubview(moonStatusLabel)
        contentView.addSubview(sunriseLabel)
        contentView.addSubview(sunriseTime)
        contentView.addSubview(sunsetLabel)
        contentView.addSubview(sunsetTime)
        contentView.addSubview(lightDayTimeLabel)
        contentView.addSubview(airConditionLabel)
        contentView.addSubview(airConditionNumber)
        contentView.addSubview(airConditionButton)
        contentView.addSubview(airConditionText)
    }

    private func layout() {

        createViews()

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
        }

        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.height.equalTo(65)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }

        mainScrollView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(dateCollectionView.snp.bottom).offset(10)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.snp.top)
            make.leading.equalTo(mainScrollView.snp.leading)
            make.trailing.equalTo(mainScrollView.snp.trailing)
            make.width.equalTo(mainScrollView.snp.width)
            make.bottom.equalTo(mainScrollView.snp.bottom)
        }

        dayNightTableView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }

        sunAndMoonLabel.snp.makeConstraints { make in
            make.top.equalTo(dayNightTableView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(22)
        }

        moonStatusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sunAndMoonLabel.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.equalTo(19)
        }

        sunImage.snp.makeConstraints { make in
            make.top.equalTo(sunAndMoonLabel.snp.bottom).offset(17)
            make.leading.equalTo(contentView.snp.leading).offset(34)
            make.height.equalTo(23)
            make.width.equalTo(20)
        }

        moonImage.snp.makeConstraints { make in
            make.centerY.equalTo(sunImage.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-120)
            make.height.equalTo(23)
            make.width.equalTo(20)
        }

        lightDayTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sunImage.snp.centerY)
            make.leading.equalTo(sunImage.snp.trailing).offset(60)
            make.height.equalTo(20)
        }

        sunriseLabel.snp.makeConstraints { make in
            make.top.equalTo(sunImage.snp.bottom).offset(18)
            make.leading.equalTo(contentView.snp.leading).offset(34)
            make.height.equalTo(19)
        }
        sunriseTime.snp.makeConstraints { make in
            make.centerY.equalTo(sunriseLabel.snp.centerY)
            make.leading.equalTo(sunriseLabel.snp.trailing).offset(46)
            make.height.equalTo(20)
        }

        sunsetLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseLabel.snp.bottom).offset(18)
            make.leading.equalTo(contentView.snp.leading).offset(34)
            make.height.equalTo(19)
        }

        sunsetTime.snp.makeConstraints { make in
            make.centerY.equalTo(sunsetLabel.snp.centerY)
            make.leading.equalTo(sunsetLabel.snp.trailing).offset(46)
            make.height.equalTo(20)
        }

        airConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(sunsetLabel.snp.bottom).offset(25)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(22)
        }

        airConditionNumber.snp.makeConstraints { make in
            make.top.equalTo(airConditionLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(17)
            make.width.height.equalTo(40)
        }

        airConditionButton.snp.makeConstraints { make in
            make.centerY.equalTo(airConditionNumber.snp.centerY)
            make.leading.equalTo(airConditionNumber.snp.trailing).offset(15)
            make.height.equalTo(26)
            make.width.equalTo(95)
        }

        airConditionText.snp.makeConstraints { make in
            make.top.equalTo(airConditionNumber.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.equalTo(76)
        }

    }

    func updateView(dataSource: ForecastModel, hours: [HourModel], mainModel: MainForecastsModels, forecastArray: [ForecastModel]) {
        self.forecastModel = dataSource
        self.hours = hours
        self.mainModel = mainModel
        self.forecastArray = forecastArray
        cityLabel.text = "\(mainModel.country!), \(mainModel.locality!)"
        dayNightTableView.reloadData()
    }

}


extension DetailDayView: UITableViewDelegate {}

extension DetailDayView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        341
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailDayTableViewCell.id, for: indexPath) as? DetailDayTableViewCell else { return UITableViewCell() }
        guard let dataSource = forecastModel else { return UITableViewCell() }
        guard let hours = hours else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.updateDayCellWith(data: dataSource.dayModel!, hourArray: hours)
        } else {
            cell.updateNightCellWith(data: dataSource.nightModel!, hourArray: hours)
        }
        return cell
    }

}


extension DetailDayView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecastArray = forecastArray else { return 0 }
        return forecastArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailDayCollectionViewCell.id, for: indexPath) as? DetailDayCollectionViewCell else { return UICollectionViewCell() }
        guard let forecastArray = forecastArray else { return UICollectionViewCell() }
        let data = forecastArray[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }



}
extension DetailDayView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource = forecastArray![indexPath.row]
        let hoursModelService = HoursModelService(coreDataModel: dataSource)
        let hoursArray = hoursModelService.hoursArray
        self.updateView(dataSource: dataSource, hours: hoursArray, mainModel: mainModel!, forecastArray: forecastArray!)
        collectionView.reloadData()
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
