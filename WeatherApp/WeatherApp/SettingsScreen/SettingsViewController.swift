//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private let settingsView: UIView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
    }


    private func layout() {
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        settingsView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
