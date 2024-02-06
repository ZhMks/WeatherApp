//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

final class SettingsView: UIView {

    private let greyColor: UIColor = UIColor(red: 137/255, green: 131/255, blue: 131/255, alpha: 1)

    private lazy var centerView: UIView = {
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 255/255, alpha: 1)
        return centerView
    }()

    private lazy var settingsLabel: UILabel = {
        let settingsLabel = UILabel()
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        settingsLabel.textColor = .black
        settingsLabel.text = "Настройки"
        return settingsLabel
    }()

    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        temperatureLabel.textColor = greyColor
        temperatureLabel.text = "Температура"
        return temperatureLabel
    }()

    private lazy var speedOfWindLabel: UILabel = {
        let speedOfWindLabel = UILabel()
        speedOfWindLabel.translatesAutoresizingMaskIntoConstraints = false
        speedOfWindLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        speedOfWindLabel.textColor = greyColor
        speedOfWindLabel.text = "Скорость ветра"
        return speedOfWindLabel
    }()

    private lazy var timeFormatLabel: UILabel = {
        let timeFormatLabel = UILabel()
        timeFormatLabel.translatesAutoresizingMaskIntoConstraints = false
        timeFormatLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        timeFormatLabel.textColor = greyColor
        timeFormatLabel.text = "Формат времени"
        return timeFormatLabel
    }()

    private lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        notificationLabel.textColor = greyColor
        notificationLabel.text = "Уведомления"
        return notificationLabel
    }()

    private lazy var setupButton: UIButton = {
        let setupButton = UIButton(type: .system)
        setupButton.translatesAutoresizingMaskIntoConstraints = false
        setupButton.backgroundColor = UIColor(red: 242/255, green: 110/255, blue: 17/255, alpha: 1)
        setupButton.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 16)
        setupButton.setTitle("Установить", for: .normal)
        setupButton.layer.cornerRadius = 8.0
        setupButton.titleLabel?.textAlignment = .center
        return setupButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        let safeArea = safeAreaLayoutGuide
        addSubview(centerView)
        centerView.addSubview(settingsLabel)
        centerView.addSubview(temperatureLabel)
        centerView.addSubview(speedOfWindLabel)
        centerView.addSubview(timeFormatLabel)
        centerView.addSubview(notificationLabel)
        centerView.addSubview(setupButton)

        centerView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY)
        }

        settingsLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(10)
            make.top.equalTo(centerView.snp.top).offset(-15)
            
        }

        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(10)
            make.top.equalTo(settingsLabel.snp.bottom).offset(15)

        }

        speedOfWindLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(10)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(15)

        }

        timeFormatLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(10)
            make.top.equalTo(speedOfWindLabel.snp.bottom).offset(15)

        }

        notificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(10)
            make.top.equalTo(timeFormatLabel.snp.bottom).offset(15)

        }

        setupButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(25)
            make.top.equalTo(notificationLabel.snp.bottom).offset(15)
            make.bottom.equalTo(centerView.snp.bottom).offset(-10)

        }

    }

}
