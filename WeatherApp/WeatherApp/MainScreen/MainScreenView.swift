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
        print(mainWeatherView.frame)
        print(self.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    private func layout() {
        addSubview(mainWeatherView)
        createOvall()
        let safeArea = safeAreaLayoutGuide
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false

        mainWeatherView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-450)
        }
    }

    private func createOvall() {
        let arcCenter = CGPoint(x: mainWeatherView.bounds.size.width / 2, y: mainWeatherView.bounds.size.height)
        print(arcCenter)
        let radius = mainWeatherView.bounds.size.width / 2
        print(radius)
        let ellipsePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: .pi, endAngle: .pi * 2, clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = 5.0

        self.layer.addSublayer(shapeLayer)
    }
}
