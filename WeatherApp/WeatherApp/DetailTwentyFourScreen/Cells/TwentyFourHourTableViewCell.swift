//
//  TwentyFourHourTableViewCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

final class TwentyFourHourTableViewCell: UITableViewCell {

    static let id = "TwentyFourHourTableViewCell"

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .black
        dateLabel.text = "17/04"
        return dateLabel
    }()

    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        timeLabel.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        timeLabel.text = "12:00"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()

    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        temperatureLabel.text = "11"
        return temperatureLabel
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
        feelingTempNumber.font = UIFont(name: "Rubik-Regular", size: 14)
        feelingTempNumber.textColor = .gray
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
        temperatureNumber.font = UIFont(name: "Rubik-Regular", size: 14)
        temperatureNumber.textColor = .gray
        temperatureNumber.text = "2 m/s ССЗ"
        temperatureNumber.translatesAutoresizingMaskIntoConstraints = false
        return temperatureNumber
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
        temperatureNumber.font = UIFont(name: "Rubik-Regular", size: 14)
        temperatureNumber.textColor = .gray
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
        cloudyNumber.font = UIFont(name: "Rubik-Regular", size: 14)
        cloudyNumber.textColor = .gray
        cloudyNumber.text = "29%"
        cloudyNumber.translatesAutoresizingMaskIntoConstraints = false
        return cloudyNumber
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        layout()
        backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(feelingsTempImageView)
        contentView.addSubview(feelingsTempLabel)
        contentView.addSubview(feelingTempNumber)
        contentView.addSubview(windSpeedImageView)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(windSpeedNumber)
        contentView.addSubview(percitipationImageView)
        contentView.addSubview(percitipationLabel)
        contentView.addSubview(percitipationNumber)
        contentView.addSubview(cloudyImageView)
        contentView.addSubview(cloudyLabel)
        contentView.addSubview(cloudyNumber)
    }

    private func layout() {
        createViews()

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-280)
            make.height.equalTo(22)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(19)
        }


        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-328)
            make.height.equalTo(22)
        }

        feelingsTempImageView.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(11)
            make.height.width.equalTo(12)
        }

        feelingsTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(feelingsTempImageView.snp.centerY)
            make.leading.equalTo(feelingsTempImageView.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-45)
            make.height.equalTo(19)
        }

        feelingTempNumber.snp.makeConstraints { make in
            make.centerY.equalTo(feelingsTempLabel.snp.centerY)
            make.leading.equalTo(feelingsTempLabel.snp.trailing).offset(-5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.height.equalTo(19)
        }

        windSpeedImageView.snp.makeConstraints { make in
            make.top.equalTo(feelingsTempImageView.snp.bottom).offset(12)
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(11)
            make.height.width.equalTo(12)
        }

        windSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedImageView.snp.centerY)
            make.leading.equalTo(windSpeedImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-80)
            make.height.equalTo(19)
        }

        windSpeedNumber.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedLabel.snp.centerY)
            make.leading.equalTo(windSpeedLabel.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.height.equalTo(19)
        }

        percitipationImageView.snp.makeConstraints { make in
            make.top.equalTo(windSpeedImageView.snp.bottom).offset(12)
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(11)
            make.height.width.equalTo(12)
        }

        percitipationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(percitipationImageView.snp.centerY)
            make.leading.equalTo(percitipationImageView.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-45)
            make.height.equalTo(19)

        }

        percitipationNumber.snp.makeConstraints { make in
            make.centerY.equalTo(percitipationLabel.snp.centerY)
            make.leading.equalTo(percitipationLabel.snp.trailing).offset(-5)
            make.height.equalTo(19)
        }

        cloudyImageView.snp.makeConstraints { make in
            make.top.equalTo(percitipationImageView.snp.bottom).offset(12)
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(11)
            make.height.width.equalTo(12)
        }

        cloudyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cloudyImageView.snp.centerY)
            make.leading.equalTo(cloudyImageView.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-45)
            make.height.equalTo(19)

        }

        cloudyNumber.snp.makeConstraints { make in
            make.centerY.equalTo(cloudyLabel.snp.centerY)
            make.leading.equalTo(cloudyLabel.snp.trailing).offset(-5)
            make.height.equalTo(19)
        }


    }

    func updateCellWithData(model: HourModel) {

        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E, dd/MM"

        let stringFromDate = dateFormatter.string(from: currentTime)

        timeLabel.text = model.hour
        temperatureLabel.text = "\(model.temp)°"
        feelingTempNumber.text = "\(model.feelsLike)°"
        windSpeedNumber.text = "\(model.windSpeed.rounded(.towardZero)) \(model.windDir!)"
        percitipationNumber.text = "\(model.precStr)"
        cloudyNumber.text = "\(model.cloudness)"
        dateLabel.text = "\(stringFromDate)"
    }


}
