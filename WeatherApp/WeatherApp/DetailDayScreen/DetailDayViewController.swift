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

        let backButton = UIBarButtonItem()
        backButton.title = "Прогноз на день"
        backButton.tintColor = .gray

        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        view.addSubview(detailDayView)

        detailDayView.translatesAutoresizingMaskIntoConstraints = false

        detailDayView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func updateDataForView(data: [ForecastModel]?) {
        guard let data = data else { return }
        detailDayView.updateView(dataSource: data)
    }

}
