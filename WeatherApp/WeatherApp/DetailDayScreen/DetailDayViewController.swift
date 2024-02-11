//
//  DetailDayViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit

class DetailDayViewController: UIViewController {

    private let detailDayView = DetailDayView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layout()
    }
    

    private func layout() {
        
        view.addSubview(detailDayView)

        detailDayView.translatesAutoresizingMaskIntoConstraints = false

        detailDayView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
