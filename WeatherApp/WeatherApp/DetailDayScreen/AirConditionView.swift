//
//  AirConditionView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 11.03.2024.
//

import Foundation
import UIKit
import SnapKit

final class AirConditionView: UIView {
    private lazy var airConditionLabel: UILabel = {
        let airConditionLabel = UILabel()
        airConditionLabel.text = "Качество воздуха"
        airConditionLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        airConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        return airConditionLabel
    }()

    private lazy var airConditionNumber: UILabel = {
        let airCondtionNumber = UILabel()
        airCondtionNumber.font = UIFont(name: "Rubik-Regular", size: 30)
        airCondtionNumber.text = "42"
        airCondtionNumber.translatesAutoresizingMaskIntoConstraints = false
        return airCondtionNumber
    }()

    private lazy var airConditionButton: UIButton = {
        let airCondtionButton = UIButton(type: .system)
        airCondtionButton.isEnabled = false
        airCondtionButton.setTitle("Хорошо", for: .normal)
        airCondtionButton.setTitleColor(.white, for: .normal)
        airCondtionButton.backgroundColor = .systemGreen
        airCondtionButton.translatesAutoresizingMaskIntoConstraints = false
        airCondtionButton.layer.cornerRadius = 8
        return airCondtionButton
    }()

    private lazy var airConditionText: UILabel = {
        let airConditionText = UILabel()
        airConditionText.translatesAutoresizingMaskIntoConstraints = false
        airConditionText.font = UIFont(name: "Rubik-Regular", size: 14)
        airConditionText.numberOfLines = 0
        airConditionText.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        airConditionText.text = """
    Качество воздуха считается
    удовлетворительным и загрязнения
    воздуха представляются незначительными
    в пределах нормы
"""
        return airConditionText
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(airConditionLabel)
        addSubview(airConditionButton)
        addSubview(airConditionText)
        addSubview(airConditionNumber)
    }

    private func layout() {
        addViews()
        
        airConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-40)
        }

        airConditionNumber.snp.makeConstraints { make in
            make.top.equalTo(airConditionLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-330)
        }

        airConditionButton.snp.makeConstraints { make in
            make.top.equalTo(airConditionLabel.snp.bottom).offset(10)
            make.leading.equalTo(airConditionNumber.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-190)
        }

        airConditionText.snp.makeConstraints { make in
            make.top.equalTo(airConditionNumber.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
}
