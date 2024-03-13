//
//  TempChartView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 13.03.2024.
//

import Foundation
import UIKit
import Charts
import DGCharts


final class TempChartView: UIView, ChartViewDelegate {

    private var dataSource: [HourModel]?


    private lazy var lineChartview: LineChartView = {
        let chartView = LineChartView()
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.backgroundColor = .clear
        chartView.drawGridBackgroundEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.legend.enabled = false

        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        xAxis.axisLineDashLengths = [CGFloat(6.0)]

        let yAxis = chartView.leftAxis
        yAxis.drawGridLinesEnabled = false
        yAxis.drawLabelsEnabled = false
        yAxis.axisLineDashLengths = [CGFloat(6.0)]
        yAxis.axisLineColor = .black


        chartView.xAxis.axisLineColor = .black


        return chartView
    }()

    func updateView(data: [HourModel]) {
        self.dataSource = data
        layout()
        setData()
    }

    private func layout() {
        addSubview(lineChartview)
        lineChartview.snp.makeConstraints { make in
            make.height.equalTo(self)
            make.width.equalTo(self)
            make.center.equalTo(self.snp.center)
        }
    }


    private func setData() {
        var xValues = [HourModel]()

        for index in stride(from: 0, to: dataSource!.count, by: 3) {
            let valueToAppend = dataSource![index]
            xValues.append(valueToAppend)
        }

        var dataForYCharts = [ChartDataEntry]()

        for hour in xValues {
            let newChartData = ChartDataEntry(x: Double(hour.hour!.replacingOccurrences(of: ":", with: "."))!, y: Double(hour.temp))
            dataForYCharts.append(newChartData)
        }

        let set1 = LineChartDataSet(entries: dataForYCharts)
        set1.mode = .linear
        set1.circleRadius = CGFloat(3.0)
        set1.circleColors = [.white]
        set1.drawCirclesEnabled = true

        let colorTop =  UIColor(red: 61/255.0, green: 105.0/255.0, blue: 220.0/255.0, alpha: 1).cgColor
        let middleColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 32.0/255.0, green: 78.0/255.0, blue: 199.0/255.0, alpha: 0.3).cgColor

        let gradientColors = [colorTop, middleColor, colorBottom] as CFArray
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)
        lineChartview.data = data
    }


}

