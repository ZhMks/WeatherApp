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
        mainScreenView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        mainScreenView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }
}
