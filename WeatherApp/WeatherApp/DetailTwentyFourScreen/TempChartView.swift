//
//  TempChartView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 23.02.2024.
//

import Foundation
import UIKit

final class TempChartView: UIView {
    private var hoursArray: [HourModel]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createDottedBorder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createDottedBorder() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: 20))
        path.addLine(to: CGPoint(x: 5 , y: 150))

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 8]
        shapeLayer.path = path.cgPath

        layer.addSublayer(shapeLayer)
    }

}
