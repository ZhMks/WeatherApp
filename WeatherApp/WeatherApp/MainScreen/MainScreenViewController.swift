//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit

class MainScreenViewController: UIViewController {

    private let mainScreenView = MainScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    private func layout() {
        view.addSubview(mainScreenView)
        navigationItem.title = "Ulyanovsk, Russia"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Burger"), style: .plain, target: self, action: #selector(burgerButtonTapped(_:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Landmark"), style: .plain, target: self, action: #selector(rightButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
        mainScreenView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        mainScreenView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()

        navigationController?.pushViewController(settingsVC, animated: true)

    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {}
}
