//
//  DetailTwentyFourView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit
import Charts
import DGCharts

final class DetailTwentyFourView: UIView {

    var dataArray: [HourModel]?

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.text = "Ulyanovsk, Russia"
        cityLabel.textColor = .black
        return cityLabel
    }()

    private lazy var lineChart: LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = .clear
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.backgroundColor = .clear
        lineChart.drawGridBackgroundEnabled = false
        lineChart.pinchZoomEnabled = false
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false



        let yAxis = lineChart.leftAxis
        yAxis.axisLineColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        yAxis.drawLabelsEnabled = false
        yAxis.labelTextColor = .black
        yAxis.inverted = true
        yAxis.drawGridLinesEnabled = false
        yAxis.axisLineDashLengths = [CGFloat(6.0)]
        yAxis.gridLineWidth = CGFloat(3.0)


        let xAxis = lineChart.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        xAxis.axisLineDashLengths = [CGFloat(6.0)]

        lineChart.xAxis.axisLineColor = .black

        return lineChart
    }()

    private lazy var chartView: UIView = {
        let chartView = UIView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = UIColor(red: 233/255, green: 258/255, blue: 250/255, alpha: 1)
        return chartView
    }()

    private lazy var twentyFourOurTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TwentyFourHourTableViewCell.self, forCellReuseIdentifier: TwentyFourHourTableViewCell.id)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .blue
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        let safeArea = safeAreaLayoutGuide
        addSubview(cityLabel)
        addSubview(chartView)
        addSubview(twentyFourOurTableView)
        chartView.addSubview(lineChart)


        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(48)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-130)
        }

        chartView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading)
            make.trailing.equalTo(safeArea.snp.trailing)
            make.height.equalTo(152)
        }

        twentyFourOurTableView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(safeArea)
        }

        lineChart.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.top)
            make.leading.equalTo(chartView.snp.leading)
            make.trailing.equalTo(chartView.snp.trailing)
            make.bottom.equalTo(chartView.snp.bottom)
        }
    }

    func updateView(with model: [HourModel]) {
        self.dataArray = model
        setData()
        twentyFourOurTableView.reloadData()
    }

}


extension DetailTwentyFourView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        135
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = dataArray?.count else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwentyFourHourTableViewCell.id, for: indexPath) as? TwentyFourHourTableViewCell else { return UITableViewCell()}
        guard let data = dataArray?[indexPath.row] else { return UITableViewCell() }
        cell.updateCellWithData(model: data )
        return cell
    }
    

}

extension DetailTwentyFourView: UITableViewDelegate {

}

extension DetailTwentyFourView: ChartViewDelegate {

    func setData() { 
        var xValues = [HourModel]()

        for index in stride(from: 0, to: dataArray!.count, by: 3) {
            let valueToAppend = dataArray![index]
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

        let colorTop =  UIColor(red: 61/255.0, green: 105.0/255.0, blue: 220.0/255.0, alpha: 0.3).cgColor
        let colorBottom = UIColor(red: 32.0/255.0, green: 78.0/255.0, blue: 199.0/255.0, alpha: 0.0).cgColor

        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set1.gradientPositions = colorLocations
        set1.fill = LinearGradientFill(gradient: gradient!)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)
        lineChart.data = data

    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

    }
}
