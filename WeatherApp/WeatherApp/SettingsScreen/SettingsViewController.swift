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
}

class SettingsViewController: UIViewController, ISettingsViewController {

    private let settingsView: UIView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
    }


    private func layout() {
        view.addSubview(settingsView)
//        settingsView.settingsVC = self
        settingsView.translatesAutoresizingMaskIntoConstraints = false

        settingsView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
