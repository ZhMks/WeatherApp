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
        }

        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(percentage.snp.leading).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.height.equalTo(17)
            make.width.equalTo(15)
        }

        percentage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.trailing.equalTo(mainLabelText.snp.leading).offset(12)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }

        mainLabelText.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(17)
            make.trailing.equalTo(temperatureLabel.snp.leading).offset(-5)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(17)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
        }
    }

    func updateCellWith(model: ForecastModel) {
        dateLabel.text = "\((model.date)!)"
        percentage.text = "\((model.dayModel?.precProb)!)"
        mainLabelText.text = "\((model.dayModel?.condition)!)"
        temperatureLabel.text = "\((model.dayModel?.tempAvg)!)"
    }

}
