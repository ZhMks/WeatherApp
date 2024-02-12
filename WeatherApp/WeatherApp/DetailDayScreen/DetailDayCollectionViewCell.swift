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
        return dateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(dateLabel)

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(44)
            make.height.equalTo(88)
        }
    }

}
