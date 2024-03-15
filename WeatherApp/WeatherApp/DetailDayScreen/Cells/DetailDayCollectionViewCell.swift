//
//  DetailDayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import UIKit
import SnapKit


final class DetailDayCollectionViewCell: UICollectionViewCell {
    static let id = "DetailDayCollectionViewCell"

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        dateLabel.text = "15/04/ ПТ"
        dateLabel.textColor = .black
        return dateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(dateLabel)

        dateLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
        }
    }

    func configureCell(data: ForecastModel) {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let timeString = dateFormatter.date(from: (data.date)!)
        let currentDateString = dateFormatter.string(from: currentDate)
        let forecastDateString = dateFormatter.string(from: timeString!)


        let secondFormatter = DateFormatter()
        secondFormatter.dateFormat = "EE,d/MM"
        secondFormatter.locale = Locale(identifier: "ru_RU")
        let dateStrin = secondFormatter.string(from: (timeString)!)
        dateLabel.text = "\(dateStrin)"
    }

    func performUpdate() {
        if isSelected {
            backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
            dateLabel.textColor = .white
        } else {
            backgroundColor = .clear
            dateLabel.textColor = .black
        }
    }
}
