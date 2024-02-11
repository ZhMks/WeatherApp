//
//  DetailTwentyFourViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

class DetailTwentyFourViewController: UIViewController {

    private let detailView = DetailTwentyFourView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    

    private func layout() {
        view.addSubview(detailView)
        let backButton = UIBarButtonItem()
        backButton.title = "Прогноз на 24 часа"
        backButton.tintColor = .gray
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let safeArea = view.safeAreaLayoutGuide
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(safeArea)
        }
    }

}
