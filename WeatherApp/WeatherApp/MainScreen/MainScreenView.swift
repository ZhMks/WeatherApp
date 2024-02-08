//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

final class MainScreenView: UIView {

    private let mainWeatherView = WeatherView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    private func layout() {
        addSubview(mainWeatherView)
        let safeArea = safeAreaLayoutGuide
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false

        mainWeatherView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-450)
        }
    }
}
