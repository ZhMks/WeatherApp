//
//  TempChartView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 23.02.2024.
//

import Foundation
import UIKit
import Charts
import DGCharts

final class TempChartView: UIView, ChartViewDelegate {

    let lineChartView = LineChartView()

    private var hoursArray: [HourModel]?
    private var entries = [ChartDataEntry]()

    private func setupChart() {
        addSubview(lineChartView)
        lineChartView.delegate = self
        lineChartView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }

    func updateDataSource(hours: [HourModel]) {
        self.hoursArray = hours
        createDataForEntries()
        setupChart()
    }


    private func createDataForEntries() {

        

        if let hoursArray = hoursArray {
            for hour in hoursArray {
                entries.append(ChartDataEntry(x: Double(hour.hour!)!, y: Double(hour.temp)))
                print(entries.count)
            }
        }
        let set = LineChartDataSet(entries: entries)
        set.colors = [UIColor.blue]
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
    }



}
