//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

protocol ISettingsViewController: AnyObject {
    func dismiss()
    func changeToKM()
    func changeToCelsium()
    func changeToTvelveHourFormat()
}

class SettingsViewController: UIViewController, ISettingsViewController {

    private let mainModel: MainForecastsModels

    private let settingsView: SettingsView = SettingsView()
    private var forecastModelService: ForecastModelService?

    init( mainModel: MainForecastsModels) {
        self.mainModel = mainModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingsView.checkSegmentedValue()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
        updateModel()
    }


    private func layout() {
        view.addSubview(settingsView)
        settingsView.settingsVC = self
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        settingsView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func updateModel() {
        let forecastModelService = ForecastModelService(coreDataModel: mainModel)
        self.forecastModelService = forecastModelService
    }

    func dismiss() {
        dismiss(animated: true)
    }

    func changeToKM() {
        if let speedValue = UserDefaults.standard.value(forKey: "distance") as? String {
            switch speedValue {
            case "Km":
                ValueConverter.shared.convertToKM()
            case "Mi":
                ValueConverter.shared.convertToMiles()
            default: break
            }
        }
    }

    func changeToCelsium() {
        if let tempValue = UserDefaults.standard.value(forKey: "temperature") as? String {
            switch tempValue {
            case "C":
                ValueConverter.shared.convertToCelsius()
            case "F":
                ValueConverter.shared.convertToFahrenheit()
            default: break
            }
        }
    }

    func changeToTvelveHourFormat() {
        if let timeValue = UserDefaults.standard.value(forKey: "time") as? String {
            switch timeValue {
            case "24":
                ValueConverter.shared.convertTwentyFourHour()
            case "12":
                ValueConverter.shared.convertTwelveHour()
            default: break
            }
        }
    }


}
