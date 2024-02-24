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

    private let settingsView: SettingsView = SettingsView()
    private var coreDataModelService: CoreDataModelService
    private var forecastModelService: ForecastModelService?

    init(coreDataModelService: CoreDataModelService) {
        self.coreDataModelService = coreDataModelService
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
        guard let model = coreDataModelService.modelArray?.first else { return }
        let forecastModelService = ForecastModelService(coreDataModel: model)
        self.forecastModelService = forecastModelService
    }

    func dismiss() {
        dismiss(animated: true)
    }

    func changeToKM() {
        guard let forecastModelService = self.forecastModelService else { return }
        forecastModelService.convertSpeedValues()
    }

    func changeToCelsium() {
        guard let forecastModelService = self.forecastModelService else { return }
        forecastModelService.convertTempValues()
    }

    func changeToTvelveHourFormat() {
        guard let forecastModelService = self.forecastModelService else { return }
        forecastModelService.convertHourFormat()
    }


}
