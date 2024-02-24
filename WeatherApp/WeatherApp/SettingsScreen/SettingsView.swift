//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

final class SettingsView: UIView {

    var settingsVC: ISettingsViewController?

    private let greyColor: UIColor = UIColor(red: 137/255, green: 131/255, blue: 131/255, alpha: 1)
    private let segmentedBackground: UIColor = UIColor(red: 254/255, green: 237/255, blue: 233/255, alpha: 1)
    private let selectedBackground: UIColor = UIColor(red: 31/255, green: 77/255, blue: 191/255, alpha: 1)

    private lazy var centerView: UIView = {
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 255/255, alpha: 1)
        centerView.layer.cornerRadius = 8.0
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
        temperatureLabel.font = UIFont(name: "Rubik-Regular" , size: 16)
        temperatureLabel.textColor = greyColor
        temperatureLabel.text = "Температура"
        return temperatureLabel
    }()

    private lazy var speedOfWindLabel: UILabel = {
        let speedOfWindLabel = UILabel()
        speedOfWindLabel.translatesAutoresizingMaskIntoConstraints = false
        speedOfWindLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        speedOfWindLabel.textColor = greyColor
        speedOfWindLabel.text = "Скорость ветра"
        return speedOfWindLabel
    }()

    private lazy var timeFormatLabel: UILabel = {
        let timeFormatLabel = UILabel()
        timeFormatLabel.translatesAutoresizingMaskIntoConstraints = false
        timeFormatLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        timeFormatLabel.textColor = greyColor
        timeFormatLabel.text = "Формат времени"
        return timeFormatLabel
    }()

    private lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        notificationLabel.textColor = greyColor
        notificationLabel.text = "Уведомления"
        return notificationLabel
    }()

    private lazy var setupButton: UIButton = {
        let setupButton = UIButton(type: .system)
        setupButton.translatesAutoresizingMaskIntoConstraints = false
        setupButton.backgroundColor = UIColor(red: 242/255, green: 110/255, blue: 17/255, alpha: 1)
        setupButton.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        setupButton.setTitle("Установить", for: .normal)
        setupButton.layer.cornerRadius = 8.0
        setupButton.titleLabel?.textAlignment = .center
        setupButton.setTitleColor(.white, for: .normal)
        setupButton.addTarget(self, action: #selector(tapOnSetButton(_:)), for: .touchUpInside)
        return setupButton
    }()

    private lazy var temperatureSegmentedControle: UISegmentedControl = {
        let segmentedControle = UISegmentedControl(items: ["C", "F"])
        segmentedControle.translatesAutoresizingMaskIntoConstraints = false
        segmentedControle.backgroundColor = segmentedBackground
        segmentedControle.selectedSegmentTintColor = selectedBackground
        segmentedControle.selectedSegmentIndex = 0
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControle.addTarget(self, action: #selector(tempSegmentedControlValueChange(_:)), for: .valueChanged)
        return segmentedControle
    }()

    private lazy var windSegmentedControle: UISegmentedControl = {
        let segmentedControle = UISegmentedControl(items: ["Km", "Mi"])
        segmentedControle.translatesAutoresizingMaskIntoConstraints = false
        segmentedControle.backgroundColor = segmentedBackground
        segmentedControle.selectedSegmentTintColor = selectedBackground
        segmentedControle.selectedSegmentIndex = 0
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControle.addTarget(self, action: #selector(distanceSegmentedControlValueChange(_:)), for: .valueChanged)
        return segmentedControle
    }()

    private lazy var timeSegmentedControle: UISegmentedControl = {
        let segmentedControle = UISegmentedControl(items: ["24", "12"])
        segmentedControle.translatesAutoresizingMaskIntoConstraints = false
        segmentedControle.backgroundColor = segmentedBackground
        segmentedControle.selectedSegmentTintColor = selectedBackground
        segmentedControle.selectedSegmentIndex = 0
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControle.addTarget(self, action: #selector(timeSegmentedControlValueChange(_:)), for: .valueChanged)
        return segmentedControle
    }()

    private lazy var notificationsSegmentedControle: UISegmentedControl = {
        let segmentedControle = UISegmentedControl(items: ["On", "Off"])
        segmentedControle.translatesAutoresizingMaskIntoConstraints = false
        segmentedControle.backgroundColor = segmentedBackground
        segmentedControle.selectedSegmentTintColor = selectedBackground
        segmentedControle.selectedSegmentIndex = 1
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return segmentedControle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
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
        centerView.addSubview(temperatureSegmentedControle)
        centerView.addSubview(windSegmentedControle)
        centerView.addSubview(timeSegmentedControle)
        centerView.addSubview(notificationsSegmentedControle)

        centerView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(241)
            make.leading.equalTo(safeArea.snp.leading).offset(28)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-27)
        }

        settingsLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(20)
            make.top.equalTo(centerView.snp.top).offset(27)

        }

        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(20)
            make.centerY.equalTo(temperatureSegmentedControle.snp.centerY)

        }

        temperatureSegmentedControle.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top).offset(57)
            make.trailing.equalTo(centerView.snp.trailing).offset(-15)
        }

        speedOfWindLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(20)
            make.centerY.equalTo(windSegmentedControle.snp.centerY)

        }

        windSegmentedControle.snp.makeConstraints { make in
            make.top.equalTo(temperatureSegmentedControle.snp.bottom).offset(20)
            make.trailing.equalTo(centerView.snp.trailing).offset(-15)
        }

        timeFormatLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(20)
            make.centerY.equalTo(timeSegmentedControle.snp.centerY)

        }

        timeSegmentedControle.snp.makeConstraints { make in
            make.top.equalTo(windSegmentedControle.snp.bottom).offset(20)
            make.trailing.equalTo(centerView.snp.trailing).offset(-15)
        }

        notificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(centerView.snp.leading).offset(20)
            make.centerY.equalTo(notificationsSegmentedControle.snp.centerY)

        }

        notificationsSegmentedControle.snp.makeConstraints { make in
            make.top.equalTo(timeSegmentedControle.snp.bottom).offset(20)
            make.trailing.equalTo(centerView.snp.trailing).offset(-15)
        }

        setupButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top).offset(274)
            make.leading.equalTo(centerView.snp.leading).offset(35)
            make.trailing.equalTo(centerView.snp.trailing).offset(-35)
            make.bottom.equalTo(centerView.snp.bottom).offset(-16)

        }

    }

    @objc func tapOnSetButton(_: UIButton) {
        settingsVC?.dismiss()
    }

    @objc func tempSegmentedControlValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let value = UserDefaults.standard.value(forKey: "temperature") as? String {
                print(value)
                if temperatureSegmentedControle.titleForSegment(at: 0)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("C", forKey: "temperature")
                    settingsVC?.changeToCelsium()
                }
            } else {
                UserDefaults.standard.setValue("C", forKey: "temperature")
            }
        case 1:
            if let value = UserDefaults.standard.value(forKey: "temperature") as? String {
                print(value)
                if temperatureSegmentedControle.titleForSegment(at: 1)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("F", forKey: "temperature")
                    settingsVC?.changeToCelsium()
                }
            } else {
                UserDefaults.standard.setValue("F", forKey: "temperature")
            }
        default: break
        }
    }

    @objc func distanceSegmentedControlValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let value = UserDefaults.standard.value(forKey: "distance") as? String {
                print(value)
                if windSegmentedControle.titleForSegment(at: 0)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("Km", forKey: "distance")
                    settingsVC?.changeToKM()
                }
            } else {
                UserDefaults.standard.setValue("Km", forKey: "distance")
            }
        case 1:
            if let value = UserDefaults.standard.value(forKey: "distance") as? String {
                print(value)
                if windSegmentedControle.titleForSegment(at: 0)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("Mi", forKey: "distance")
                    settingsVC?.changeToKM()
                }
            } else {
                UserDefaults.standard.setValue("Mi", forKey: "distance")
            }
        default: break
        }
    }

    @objc func timeSegmentedControlValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let value = UserDefaults.standard.value(forKey: "time") as? String {
                if timeSegmentedControle.titleForSegment(at: 0)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("24", forKey: "time")
                    settingsVC?.changeToTvelveHourFormat()
                }
            } else {
                UserDefaults.standard.setValue("24", forKey: "time")
            }
        case 1:
            if let value = UserDefaults.standard.value(forKey: "time") as? String {
                if timeSegmentedControle.titleForSegment(at: 1)! == value {
                    return
                } else {
                    UserDefaults.standard.setValue("12", forKey: "time")
                    settingsVC?.changeToTvelveHourFormat()
                }
            } else {
                UserDefaults.standard.setValue("12", forKey: "time")
            }
        default: break
        }
    }

    func checkSegmentedValue() {
        if let tempValue = UserDefaults.standard.value(forKey: "temperature") as? String {
            switch tempValue {
            case "C":
                temperatureSegmentedControle.selectedSegmentIndex = 0
            case "F":
                temperatureSegmentedControle.selectedSegmentIndex = 1
            default: break
            }
        }
        if let distanceValue = UserDefaults.standard.value(forKey: "distance") as? String {
            switch distanceValue {
            case "Km":
                windSegmentedControle.selectedSegmentIndex = 0
            case "Mi":
                windSegmentedControle.selectedSegmentIndex = 1
            default: break
            }
        }
        if let timeValue = UserDefaults.standard.value(forKey: "time") as? String {
            switch timeValue {
            case "24":
                timeSegmentedControle.selectedSegmentIndex = 0
            case "12":
                timeSegmentedControle.selectedSegmentIndex = 1
            default: break
            }
        }
    }

}
