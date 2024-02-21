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
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(5)
            make.centerX.equalTo(timeLabel.snp.centerX)
        }
    }

    func updateCell(date: HourModel) {
        temperatureLabel.text = "\(date.temp)°"
        timeLabel.text = "\((date.hour)!)"
    }

}
