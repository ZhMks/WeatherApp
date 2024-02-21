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

    func configureCel(_ data: ForecastModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeString = dateFormatter.date(from: (data.date)!)

        dateFormatter.dateFormat = "E, dd/MM"

        dateLabel.text = "\(String(describing: timeString))"
    }

}
