//
//  EverydayForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 08.02.2024.
//

import UIKit
import SnapKit

final class EverydayForecastTableViewCell: UITableViewCell {

    static let id = "EverydayForecastTableViewCell"

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        dateLabel.text = "17/04"
        return dateLabel
    }()

    private lazy var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.image = UIImage(named: "CloudyImage")
        weatherImage.backgroundColor = .clear
        return weatherImage
    }()

    private lazy var percentage: UILabel = {
        let percentage = UILabel()
        percentage.translatesAutoresizingMaskIntoConstraints = false
        percentage.font = UIFont(name: "Rubik-Regular", size: 12)
        percentage.textColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        percentage.text = "57%"
        return percentage
    }()

    private lazy var mainLabelText: UILabel = {
        let mainLabelText = UILabel()
        mainLabelText.translatesAutoresizingMaskIntoConstraints = false
        mainLabelText.font = UIFont(name: "Rubik-Regular", size: 16)
        mainLabelText.textColor = .black
        mainLabelText.textAlignment = .left
        mainLabelText.text = "Преимущественно облачно"
        return mainLabelText
    }()

    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        temperatureLabel.text = "4-11"
        return temperatureLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 8.0
        backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(percentage)
        contentView.addSubview(mainLabelText)
        contentView.addSubview(temperatureLabel)

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(6)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-240)
            make.bottom.equalTo(contentView.snp.bottom).offset(-31)
        }

        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(percentage.snp.leading).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.width.equalTo(17)
        }

        percentage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.leading.equalTo(weatherImage.snp.trailing).offset(5)
            make.width.equalTo(20)
        }

        mainLabelText.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(17)
            make.leading.equalTo(percentage.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-100)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(17)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.leading.equalTo(mainLabelText.snp.trailing).offset(15)
        }
    }

    func updateCellWith(model: ForecastModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: model.date!)

        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd/MM"
        let updatedString = newDateFormatter.string(from: date!)

        guard let day = model.dayModel else { return }

        dateLabel.text = "\(updatedString)"
        percentage.text = "\(day.precProb)"
        mainLabelText.text = "\((day.condition)!)"
        temperatureLabel.text = "\(day.tempMin)° - \(day.tempMax)°"

        switch day.condition {
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
    }

}
