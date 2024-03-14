//
//  CollectionVIewCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 08.02.2024.
//

import UIKit

final class WeatherCollectionViewCell: UICollectionViewCell {

   static let id = "CollectionViewCell"


    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name: "Rubik-Medium", size: 14)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "23:00"
        return timeLabel
    }()

    lazy var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.image = UIImage(named: "CloudyImage")
        weatherImage.backgroundColor = .clear
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()

    lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont(name: "Rubik-Medium", size: 14)
        temperatureLabel.text = "23"
        temperatureLabel.textColor = .black
        return temperatureLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 18
        layer.borderColor = UIColor(red: 171/255, green: 188/255, blue: 234/1, alpha: 1).cgColor
        layer.borderWidth = 1.0
        layout()
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(temperatureLabel)

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(contentView.snp.leading).offset(3)
            make.trailing.equalTo(contentView.snp.trailing).offset(-2)
        }

        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(6)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.width.equalTo(18)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(5)
            make.centerX.equalTo(timeLabel.snp.centerX)
        }
    }

    func updateCell(hour: HourModel) {
        temperatureLabel.text = "\(hour.temp)°"
        timeLabel.text = "\((hour.hour)!)"

        switch hour.condition {
        case "Ясно":
            weatherImage.image = UIImage(named: "UfLight")
        case "Малооблачно":
            weatherImage.image = UIImage(named: "CloudyImage")
        case "Облачно с прояснениями":
            weatherImage.image = UIImage(named: "CloudyImage")
        case "Пасмурно":
            weatherImage.image = UIImage(named: "HeavyClouds")
        case "Небольшой дождь":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Дождь":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Сильный дождь":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Ливень":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Дождь со снегом":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Небольшой снег":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Снег":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Снегопад":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Град":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Гроза":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Дождь с грозой":
            weatherImage.image = UIImage(named: "PercitipationImage")
        case "Гроза с градом":
            weatherImage.image = UIImage(named: "PercitipationImage")
        default: break
        }

        if isSelected {
            backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
            temperatureLabel.textColor = .white
            timeLabel.textColor = .white
        }
    }

}
