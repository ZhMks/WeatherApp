//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

protocol IMainScreenController: AnyObject {
    func pushTwentyFourVc()
    func pushDayNightVc()
}

class MainScreenViewController: UIViewController, IMainScreenController {

    private let networkService: INetworkService = NetworkService()

    private let mainScreenView = MainScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        networkService.fetchData(lat: 55.75396, lon: 37.620393) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func layout() {
        view.addSubview(mainScreenView)
        mainScreenView.mainScreenVC = self
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

    func pushTwentyFourVc() {
        let twentyFourVC = DetailTwentyFourViewController()
        navigationController?.pushViewController(twentyFourVC, animated: true)
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc() {
        let detailDayVC = DetailDayViewController()
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {}
}
