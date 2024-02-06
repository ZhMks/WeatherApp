//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    private let settingsView: UIView

    init(settingsView: UIView) {
        self.settingsView = settingsView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }


    private func layout() {
        view.addSubview(settingsView)
        settingsView.frame = view.frame
    }
}
