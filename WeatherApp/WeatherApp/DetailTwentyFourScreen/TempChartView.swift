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
        yAxis.axisLineColor = .systemBlue
        chartView.xAxis.axisLineColor = .systemBlue



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
            make.top.equalTo(self.snp.top)
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
            let newChartData = ChartDataEntry(x: Double(hour.hour!.replacingOccurrences(of: ":", with: "."))!,
                                              y: Double(hour.temp))
            dataForYCharts.append(newChartData)
        }

        let set1 = LineChartDataSet(entries: dataForYCharts)
        set1.mode = .linear
        set1.circleRadius = CGFloat(3.0)
        set1.circleColors = [.black]
        set1.circleHoleRadius = 2.5
        set1.circleHoleColor = .white
        set1.drawCirclesEnabled = true
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setValueTextColor(.black)
        data.setValueFormatter(self)

        lineChartview.data = data
    }
}


extension TempChartView: ValueFormatter {

    func stringForValue(_ value: Double, entry: DGCharts.ChartDataEntry, dataSetIndex: Int, viewPortHandler: DGCharts.ViewPortHandler?) -> String {
        return "\(Int(value))°"
    }
}
