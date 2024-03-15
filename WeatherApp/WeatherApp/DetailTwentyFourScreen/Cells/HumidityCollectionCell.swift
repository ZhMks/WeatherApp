//
//  HumidityCollectionCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 13.03.2024.
//

import Foundation
import UIKit


final class HumidityCollectionCell: UICollectionViewCell {
    
    static let id = "HumidityCollectionCell"

    private lazy var humidityImageView: UIImageView = {
        let cloudyImageView = UIImageView()
        cloudyImageView.translatesAutoresizingMaskIntoConstraints = false
        cloudyImageView.image = UIImage(named: "PercitipationImage")
        cloudyImageView.backgroundColor = .clear
        return cloudyImageView
    }()

    private lazy var humidityPercent: UILabel = {
        let humidityPercent = UILabel()
        humidityPercent.translatesAutoresizingMaskIntoConstraints = false
        humidityPercent.font = UIFont(name: "Rubik-Regular", size: 10)
        humidityPercent.text = "57%"
        return humidityPercent
    }()

    private lazy var hourLabel: UILabel = {
        let hourLabel = UILabel()
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        hourLabel.text = "12:00"
        return hourLabel
    }()

    private lazy var blueLine: UIView = {
        let blueLine = UIView()
        blueLine.translatesAutoresizingMaskIntoConstraints = false
        blueLine.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return blueLine
    }()
    private lazy var blueRectangle: UIView = {
        let blueRectangle = UIView()
        blueRectangle.translatesAutoresizingMaskIntoConstraints = false
        blueRectangle.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return blueRectangle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(humidityImageView)
        contentView.addSubview(humidityPercent)
        contentView.addSubview(blueLine)
        contentView.addSubview(blueRectangle)
        contentView.addSubview(hourLabel)

        humidityImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-60)
            make.trailing.equalTo(self.snp.trailing).offset(-30)
        }

        humidityPercent.snp.makeConstraints { make in
            make.top.equalTo(humidityImageView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
        }

        blueLine.snp.makeConstraints { make in
            make.top.equalTo(humidityPercent.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(1)
        }

        blueRectangle.snp.makeConstraints { make in
            make.top.equalTo(blueLine.snp.top).offset(-4)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(8)
            make.width.equalTo(4)
        }

        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(blueRectangle.snp.bottom).offset(7)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }

    func updateData(data: HourModel) {
        humidityPercent.text = "\(String(data.humidity))%"
        hourLabel.text = data.hour!
    }
}
