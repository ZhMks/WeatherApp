//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 07.02.2024.
//

import UIKit
import SnapKit

final class WeatherView: UIView {

    var hourArray: [HourModel]?

    private let yellowColor = UIColor(red: 246/255, green: 221/255, blue: 1/255, alpha: 1)


    private lazy var devidedTemperature: UILabel = {
        let devidedTemperature = UILabel()
        devidedTemperature.font = UIFont(name: "Rubik-Regular", size: 16)
        devidedTemperature.textColor = .white
        devidedTemperature.translatesAutoresizingMaskIntoConstraints = false
        return devidedTemperature
    }()

    private lazy var mainTemperatureLabel: UILabel = {
        let mainTemperature = UILabel()
        mainTemperature.translatesAutoresizingMaskIntoConstraints = false
        mainTemperature.font = UIFont(name: "Rubik-Regular", size: 36)
        mainTemperature.textColor = .white
        return mainTemperature
    }()

    private lazy var mainWeatherLabel: UILabel = {
        let mainWeatherLabel = UILabel()
        mainWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        mainWeatherLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        mainWeatherLabel.textColor = .white
        return mainWeatherLabel
    }()

    private lazy var cloudyLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        percitipationLabel.textColor = .white
        return percitipationLabel
    }()

    private lazy var windSpeedLabel: UILabel = {
        let windSpeed = UILabel()
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        windSpeed.font = UIFont(name: "Rubik-Regular", size: 14)
        windSpeed.textColor = .white
        return windSpeed
    }()

    private lazy var percitipationLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        percitipationLabel.textColor = .white
        return percitipationLabel
    }()

    private lazy var dateTimeLabel: UILabel = {
        let dateTimeLabel = UILabel()
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        dateTimeLabel.text = "17:48, ПТ 16 Апреля"
        dateTimeLabel.textColor = yellowColor
        return dateTimeLabel
    }()


    private lazy var dawnTimeLabel: UILabel = {
        let dawnTimeLabel = UILabel()
        dawnTimeLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        dawnTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dawnTimeLabel.text = "5.20"
        dawnTimeLabel.textColor = .white
        return dawnTimeLabel
    }()

    private lazy var sunsetTimeLabel: UILabel = {
        let sunsetTimeLabel = UILabel()
        sunsetTimeLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        sunsetTimeLabel.text = "21.20"
        sunsetTimeLabel.textColor = .white
        return sunsetTimeLabel
    }()

    private lazy var dawnTimeImageView: UIImageView = {
        let dawnTimeImageView = UIImageView(image: UIImage(named: "DawnTimeImage"))
        dawnTimeImageView.translatesAutoresizingMaskIntoConstraints = false
        dawnTimeImageView.backgroundColor = .clear
        dawnTimeImageView.image?.withTintColor(yellowColor)
        sunsetTimeImageView.clipsToBounds = true
        return dawnTimeImageView
    }()

    private lazy var sunsetTimeImageView: UIImageView = {
        let sunsetTimeImageView = UIImageView(image: UIImage(named: "SunsetImage"))
        sunsetTimeImageView.translatesAutoresizingMaskIntoConstraints = false
        sunsetTimeImageView.backgroundColor = .clear
        sunsetTimeImageView.tintColor = yellowColor
        sunsetTimeImageView.clipsToBounds = true
        return sunsetTimeImageView
    }()

    private lazy var cloudyImageView: UIImageView = {
        let cloudyImageView = UIImageView(image: UIImage(named: "CloudyImage"))
        cloudyImageView.translatesAutoresizingMaskIntoConstraints = false
        cloudyImageView.clipsToBounds = true
        return cloudyImageView
    }()

    private lazy var windSpeedImageView: UIImageView = {
        let windSpeedImage = UIImageView(image: UIImage(named: "WindSpeedImage"))
        windSpeedImage.translatesAutoresizingMaskIntoConstraints = false
        windSpeedImage.clipsToBounds = true
        return windSpeedImage
    }()

    private lazy var percitipationImageView: UIImageView = {
        let percitipationImage = UIImageView(image: UIImage(named: "PercitipationImage"))
        percitipationImage.translatesAutoresizingMaskIntoConstraints = false
        percitipationImage.clipsToBounds = true
        return percitipationImage
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layoutViews()
        layer.cornerRadius = 8.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createView() {
        addSubview(devidedTemperature)
        addSubview(mainTemperatureLabel)
        addSubview(mainWeatherLabel)
        addSubview(cloudyLabel)
        addSubview(windSpeedLabel)
        addSubview(percitipationLabel)
        addSubview(dateTimeLabel)
        addSubview(sunsetTimeLabel)
        addSubview(dawnTimeLabel)
        addSubview(sunsetTimeImageView)
        addSubview(dawnTimeImageView)
        addSubview(cloudyImageView)
        addSubview(windSpeedImageView)
        addSubview(percitipationImageView)
    }

    private func layoutViews() {
        createView()
        createOvall()
        let safeArea = safeAreaLayoutGuide

        devidedTemperature.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(30)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        mainTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(devidedTemperature.snp.bottom).offset(20)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        mainWeatherLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.top.equalTo(mainTemperatureLabel.snp.bottom).offset(20)
        }

        cloudyImageView.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherLabel.snp.bottom).offset(30)
            make.leading.equalTo(safeArea.snp.leading).offset(90)
            make.trailing.equalTo(cloudyLabel.snp.leading).offset(-5)
            make.height.equalTo(18)
            make.width.equalTo(25)
        }

        cloudyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cloudyImageView.snp.centerY)
            make.leading.equalTo(cloudyImageView.snp.trailing).offset(5)
        }

        windSpeedImageView.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherLabel.snp.bottom).offset(30)
            make.leading.equalTo(cloudyLabel.snp.trailing).offset(15)
            make.height.equalTo(18)
            make.width.equalTo(21)
        }

        windSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedImageView.snp.centerY)
            make.leading.equalTo(windSpeedImageView.snp.trailing).offset(5)
        }

        percitipationImageView.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherLabel.snp.bottom).offset(30)
            make.leading.equalTo(windSpeedLabel.snp.trailing).offset(20)
            make.height.equalTo(18)
            make.width.equalTo(21)
        }

        percitipationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(percitipationImageView.snp.centerY)
            make.leading.equalTo(percitipationImageView.snp.trailing).offset(5)
        }

        dateTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(110)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-90)
        }

        dawnTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.top.equalTo(safeArea.snp.top).offset(205)
        }

        dawnTimeImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(175)
            make.bottom.equalTo(dawnTimeLabel.snp.top).offset(-5)
            make.centerX.equalTo(dawnTimeLabel.snp.centerX)
        }
        sunsetTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.top.equalTo(safeArea.snp.top).offset(205)
        }
        sunsetTimeImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(175)
            make.centerX.equalTo(sunsetTimeLabel.snp.centerX)
            make.bottom.equalTo(sunsetTimeLabel.snp.top).offset(-5)
        }

    }

    private func createOvall() {
        let arcCenter = CGPoint(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 4.95)
        let radius = UIScreen.main.bounds.width / 2.5
        let ellipsePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: .pi, endAngle: .pi * 2, clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = yellowColor.cgColor
        shapeLayer.lineWidth = 5.0

        self.layer.addSublayer(shapeLayer)
    }

    func updateView(fact: ForecastModel, hourModel: [HourModel]) {

        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeString = dateFormatter.string(from: currentTime)
        let components = timeString.components(separatedBy: ":")

        guard let currentHour = components.first else { return }

        if let selectedHour = hourModel.first(where: { $0.hour?.contains(currentHour) ?? false }) {
            devidedTemperature.text = "\(selectedHour.temp)°/ \((fact.dayModel?.tempMin)!)°"
            mainWeatherLabel.text = "\(selectedHour.condition!)"
            cloudyLabel.text = "\(selectedHour.cloudness)"
            percitipationLabel.text = "\(selectedHour.precStr)"
            windSpeedLabel.text = "\(selectedHour.windSpeed.rounded(.towardZero)) m/c"
            updateImageWith(hour: selectedHour)
        } else {
            dateFormatter.locale = Locale(identifier: "en_GB")
            dateFormatter.dateFormat = "h:mm a"
            let currentStringTime = dateFormatter.string(from: currentTime)
            let components = currentStringTime.components(separatedBy: ":")
            
            guard let currentHour = components.first else { return }
            
            if let selectedHour = hourModel.first(where: { $0.hour?.contains(currentHour) ?? false }) {
                devidedTemperature.text = "\(selectedHour.temp)°/ \((fact.dayModel?.tempMin)!)°"
                mainWeatherLabel.text = "\(selectedHour.condition!)"
                cloudyLabel.text = "\(selectedHour.cloudness)"
                percitipationLabel.text = "\(selectedHour.precStr)"
                windSpeedLabel.text = "\(selectedHour.windSpeed.rounded(.towardZero)) m/c"
                updateImageWith(hour: selectedHour)
            }
        }

            mainTemperatureLabel.text = "\((fact.dayModel?.tempMin)!)°"

            sunsetTimeLabel.text = "\(fact.sunset ?? "")"
            dawnTimeLabel.text = "\(fact.sunrise ?? "")"

            dateFormatter.dateFormat = "E, dd MMMM"
            dateTimeLabel.text = "\(timeString), \(dateFormatter.string(from: currentTime))"
        }

    private func updateImageWith(hour: HourModel) {
        switch hour.condition {
        case "Ясно":
            cloudyImageView.image = UIImage(named: "UfLight")
        case "Малооблачно":
            cloudyImageView.image = UIImage(named: "CloudyImage")
        case "Облачно с прояснениями":
            cloudyImageView.image = UIImage(named: "CloudyImage")
        case "Пасмурно":
            cloudyImageView.image = UIImage(named: "HeavyClouds")
        case "Небольшой дождь":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Дождь":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Сильный дождь":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Ливень":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Дождь со снегом":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Небольшой снег":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Снег":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Снегопад":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Град":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Гроза":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Дождь с грозой":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        case "Гроза с градом":
            cloudyImageView.image = UIImage(named: "PercitipationImage")
        default: break
        }
    }
}
