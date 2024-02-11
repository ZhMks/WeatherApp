//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 07.02.2024.
//

import UIKit
import SnapKit

final class WeatherView: UIView {

   private let yellowColor = UIColor(red: 246/255, green: 221/255, blue: 1/255, alpha: 1)


    private lazy var devidedTemperature: UILabel = {
        let devidedTemperature = UILabel()
        devidedTemperature.font = UIFont(name: "Rubik-Regular", size: .sixteen)
        devidedTemperature.textColor = .white
        devidedTemperature.text = "7/13"
        devidedTemperature.translatesAutoresizingMaskIntoConstraints = false
        return devidedTemperature
    }()

    private lazy var mainTemperatureLabel: UILabel = {
        let mainTemperature = UILabel()
        mainTemperature.translatesAutoresizingMaskIntoConstraints = false
        mainTemperature.font = UIFont(name: "Rubik-Regular", size: 36)
        mainTemperature.textColor = .white
        mainTemperature.text = "13"
        return mainTemperature
    }()

    private lazy var mainWeatherLabel: UILabel = {
        let mainWeatherLabel = UILabel()
        mainWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        mainWeatherLabel.font = UIFont(name: "Rubik-Regular", size: .sixteen)
        mainWeatherLabel.text = "Возможен небольшой дождь"
        mainWeatherLabel.textColor = .white
        return mainWeatherLabel
    }()

    private lazy var cloudyLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: .fourteen)
        percitipationLabel.text = "0"
        percitipationLabel.textColor = .white
        return percitipationLabel
    }()

    private lazy var windSpeedLabel: UILabel = {
        let windSpeed = UILabel()
        windSpeed.translatesAutoresizingMaskIntoConstraints = false
        windSpeed.font = UIFont(name: "Rubik-Regular", size: .fourteen)
        windSpeed.textColor = .white
        windSpeed.text = "5 m/s"
        return windSpeed
    }()

    private lazy var percitipationLabel: UILabel = {
        let percitipationLabel = UILabel()
        percitipationLabel.translatesAutoresizingMaskIntoConstraints = false
        percitipationLabel.font = UIFont(name: "Rubik-Regular", size: .fourteen)
        percitipationLabel.text = "75%"
        percitipationLabel.textColor = .white
        return percitipationLabel
    }()

    private lazy var dateTimeLabel: UILabel = {
        let dateTimeLabel = UILabel()
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.font = UIFont(name: "Rubik-Regular", size: .sixteen)
        dateTimeLabel.text = "17:48, ПТ 16 Апреля"
        dateTimeLabel.textColor = yellowColor
        return dateTimeLabel
    }()


    private lazy var dawnTimeLabel: UILabel = {
        let dawnTimeLabel = UILabel()
        dawnTimeLabel.font = UIFont(name: "Rubik-Regular", size: .fourteen)
        dawnTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dawnTimeLabel.text = "5.45"
        dawnTimeLabel.textColor = .white
        return dawnTimeLabel
    }()

    private lazy var sunsetTimeLabel: UILabel = {
        let sunsetTimeLabel = UILabel()
        sunsetTimeLabel.font = UIFont(name: "Rubik-Regular", size: .fourteen)
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
            make.leading.equalTo(safeArea.snp.leading).offset(95)
            make.trailing.equalTo(cloudyLabel.snp.leading).offset(-5)
            make.height.equalTo(18)
            make.width.equalTo(21)
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
            make.leading.equalTo(windSpeedLabel.snp.trailing).offset(15)
            make.height.equalTo(18)
            make.width.equalTo(21)
        }

        percitipationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(percitipationImageView.snp.centerY)
            make.leading.equalTo(percitipationImageView.snp.trailing).offset(5)
        }

        dateTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(115)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-90)
        }
        dawnTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(15)
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

}

private extension CGFloat {

    static var sixteen: CGFloat {
        return 16.0
    }
    static var fourteen: CGFloat {
        return 14.0
    }
}
