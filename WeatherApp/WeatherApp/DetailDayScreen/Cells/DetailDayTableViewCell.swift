//
//  DetailDayTableViewCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

final class DetailDayTableViewCell: UITableViewCell {

    static let id = "DetailDayTableViewCell"

    private lazy var dayNightLabel: UILabel = {
        let dayNightLabel = UILabel()
        dayNightLabel.translatesAutoresizingMaskIntoConstraints = false
        dayNightLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        dayNightLabel.text = "День"
        return dayNightLabel
    }()

    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView(image: UIImage(named: "PercitipationImage"))
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.backgroundColor = .clear
        return weatherImageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont(name: "Rubik-Regular", size: 30)
        temperatureLabel.text = "13"
        return temperatureLabel
    }()

    private lazy var mainWeatherLabel: UILabel = {
        let mainWeatherLabel = UILabel()
        mainWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        mainWeatherLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        mainWeatherLabel.text = "Ливни"
        return mainWeatherLabel
    }()

    private lazy var feelingsTempImageView: UIImageView = {
        let feelingsTempImageView = UIImageView(image: UIImage(named: "FeelingsTemp"))
        feelingsTempImageView.translatesAutoresizingMaskIntoConstraints = false
        return feelingsTempImageView
    }()

    private lazy var feelingsTempLabel: UILabel = {
        let feelingsTempLabel = UILabel()
        feelingsTempLabel.translatesAutoresizingMaskIntoConstraints = false
        feelingsTempLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        feelingsTempLabel.text = "По ощущениям"
        return feelingsTempLabel
    }()

    private lazy var feelingTempNumber: UILabel = {
        let feelingTempNumber = UILabel()
        feelingTempNumber.font = UIFont(name: "Rubik-Regular", size: 18)
        feelingTempNumber.text = "10"
        feelingTempNumber.translatesAutoresizingMaskIntoConstraints = false
        return feelingTempNumber
    }()

    private lazy var windSpeedImageView: UIImageView = {
        let windSpeedImage = UIImageView(image: UIImage(named: "WindSpeedImage"))
        windSpeedImage.translatesAutoresizingMaskIntoConstraints = false
        windSpeedImage.clipsToBounds = true
        return windSpeedImage
    }()

    private lazy var windSpeedLabel: UILabel = {
        let windSpeed = UILabel()
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        windSpeed.font = UIFont(name: "Rubik-Regular", size: 14)
        windSpeed.text = "Ветер"
        return windSpeed
    }()

    private lazy var windSpeedNumber: UILabel = {
        let temperatureNumber = UILabel()
        temperatureNumber.font = UIFont(name: "Rubik-Regular", size: 18)
        temperatureNumber.text = "2 m/s ССЗ"
        temperatureNumber.translatesAutoresizingMaskIntoConstraints = false
        return temperatureNumber
    }()


    private lazy var ufLightImageView: UIImageView = {
        let ufLightImageView = UIImageView(image: UIImage(named: "UfLight"))
        ufLightImageView.translatesAutoresizingMaskIntoConstraints = false
        return ufLightImageView
    }()

    private lazy var ufLightLabel: UILabel = {
        let ufLightLabel = UILabel()
        ufLightLabel.translatesAutoresizingMaskIntoConstraints = false
        ufLightLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        ufLightLabel.text = "Уф. индекс"
        return ufLightLabel
    }()

    private lazy var ufLightNumber: UILabel = {
        let ufLightNumber = UILabel()
        ufLightNumber.translatesAutoresizingMaskIntoConstraints = false
        ufLightNumber.font = UIFont(name: "Rubik-Regular", size: 18)
        ufLightNumber.text = "4"
        return ufLightNumber
    }()

    private lazy var percitipationImageView: UIImageView = {
        let percitipationImage = UIImageView(image: UIImage(named: "PercitipationImage"))
        percitipationImage.translatesAutoresizingMaskIntoConstraints = false
        percitipationImage.clipsToBounds = true
        return percitipationImage
    }()

    private lazy var percitipationLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        percitipationLabel.text = "Осадки"
        return percitipationLabel
    }()

    private lazy var percitipationNumber: UILabel = {
        let temperatureNumber = UILabel()
        temperatureNumber.font = UIFont(name: "Rubik-Regular", size: 18)
        temperatureNumber.text = "0%"
        temperatureNumber.translatesAutoresizingMaskIntoConstraints = false
        return temperatureNumber
    }()

    private lazy var cloudyImageView: UIImageView = {
        let cloudyImageView = UIImageView()
        cloudyImageView.translatesAutoresizingMaskIntoConstraints = false
        cloudyImageView.image = UIImage(named: "CloudyImage")
        cloudyImageView.backgroundColor = .clear
        return cloudyImageView
    }()


    private lazy var cloudyLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        percitipationLabel.text = "Облачность"
        return percitipationLabel
    }()

    private lazy var cloudyNumber: UILabel = {
        let cloudyNumber = UILabel()
        cloudyNumber.font = UIFont(name: "Rubik-Regular", size: 18)
        cloudyNumber.text = "29%"
        cloudyNumber.translatesAutoresizingMaskIntoConstraints = false
        return cloudyNumber
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layout()
        backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func addViews() {
        contentView.addSubview(dayNightLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(mainWeatherLabel)
        contentView.addSubview(feelingsTempImageView)
        contentView.addSubview(feelingsTempLabel)
        contentView.addSubview(feelingTempNumber)
        contentView.addSubview(windSpeedImageView)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(windSpeedNumber)
        contentView.addSubview(ufLightImageView)
        contentView.addSubview(ufLightLabel)
        contentView.addSubview(ufLightNumber)
        contentView.addSubview(percitipationImageView)
        contentView.addSubview(percitipationLabel)
        contentView.addSubview(percitipationNumber)
        contentView.addSubview(cloudyImageView)
        contentView.addSubview(cloudyLabel)
        contentView.addSubview(cloudyNumber)

    }

    private func layout() {
        addViews()
        makeConstraints()
    }

    private func makeConstraints() {
        dayNightLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(21)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-286)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-298 )
        }

        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(134)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-184)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-289)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(weatherImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-125)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-290)
        }

        mainWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(62)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(145)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-110)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-257)
        }

        feelingsTempImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(109)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-305)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-206)
        }

        feelingsTempLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(112)
            make.leading.equalTo(feelingsTempImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-186)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-210)
            }

        feelingTempNumber.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(109)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(308)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-210)
        }

        windSpeedImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(161)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-305)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-166)
        }

        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(158)
            make.leading.equalTo(windSpeedImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-248)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-164)
        }

        windSpeedNumber.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(155)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(237)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-164)
        }

        ufLightImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(200)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-305)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-114)
        }

        ufLightLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(204)
            make.leading.equalTo(ufLightImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-210)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-118)
        }

        ufLightNumber.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(201)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(233)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-118)
        }

        percitipationImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(245)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-305)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-66)
        }

        percitipationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(247)
            make.leading.equalTo(percitipationImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-244)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-75)
        }

        percitipationNumber.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(247)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(293)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-72)
        }

        cloudyImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(297)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-305)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-27)
        }

        cloudyLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(293)
            make.leading.equalTo(cloudyImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-209)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-29)
        }

        cloudyNumber.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(292)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(294)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-27)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-27)
        }

        createLineView()
    }

    func updateDayCellWith(data: DayModel, hourArray: [HourModel]) {

        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeString = dateFormatter.string(from: currentTime)
        let components = timeString.components(separatedBy: ":")

        guard let currentHour = components.first else { return }

        for hour in hourArray {
            if hour.hour! == currentHour {
                ufLightNumber.text = "\(hour.uvIndex)"
            }
        }

        feelingTempNumber.text = "\(data.feelsLike)°"
        windSpeedNumber.text = "\(data.windSpeed.rounded(.towardZero)) \((data.windDir)!)"
        percitipationNumber.text = "\(data.precProb)%"
        cloudyNumber.text = "\(data.cloudness)"
        mainWeatherLabel.text = "\((data.condition)!)"
        temperatureLabel.text = "\(data.tempAvg)°"
    }

    func updateNightCellWith(data: NightModel, hourArray: [HourModel]) {
        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeString = dateFormatter.string(from: currentTime)
        let components = timeString.components(separatedBy: ":")

        guard let currentHour = components.first else { return }

        for hour in hourArray {
            if hour.hour!.contains(currentHour) {
                ufLightNumber.text = "\(hour.uvIndex)"
            }
        }

        feelingTempNumber.text = "\(data.feelsLike)°"
        windSpeedNumber.text = "\(data.windSpeed.rounded(.towardZero)) \((data.windDir)!)"
        percitipationNumber.text = "\(data.precProb)%"
        cloudyNumber.text = "\(data.cloudness)"
        mainWeatherLabel.text = "\((data.condition)!)"
        dayNightLabel.text = "Ночь"
        temperatureLabel.text = "\(data.tempAvg)°"
    }

    private func createLineView() {
        let color = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)

        let firstLineView = UIView()
        firstLineView.translatesAutoresizingMaskIntoConstraints = false
        firstLineView.backgroundColor = color

        let secondLineView = UIView()
        secondLineView.translatesAutoresizingMaskIntoConstraints = false
        secondLineView.backgroundColor = color

        let thirdLineView = UIView()
        thirdLineView.translatesAutoresizingMaskIntoConstraints = false
        thirdLineView.backgroundColor = color

        let fourthLineView = UIView()
        fourthLineView.translatesAutoresizingMaskIntoConstraints = false
        fourthLineView.backgroundColor = color

        let fifthLineView = UIView()
        fifthLineView.translatesAutoresizingMaskIntoConstraints = false
        fifthLineView.backgroundColor = color

        contentView.addSubview(firstLineView)
        contentView.addSubview(secondLineView)
        contentView.addSubview(thirdLineView)
        contentView.addSubview(fourthLineView)
        contentView.addSubview(fifthLineView)

        firstLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(145)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-196)
        }

        secondLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(191)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-150)
        }

        thirdLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(237)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-104)
        }

        fourthLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(283)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-58)
        }

        fifthLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(329)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
    }
}
