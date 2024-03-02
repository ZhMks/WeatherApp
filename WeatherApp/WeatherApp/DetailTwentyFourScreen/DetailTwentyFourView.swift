//
//  DetailTwentyFourView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit
import SwiftUI


final class DetailTwentyFourView: UIView {

    var dataArray: [HourModel]?
    var mainModel: MainForecastsModels?

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.text = "Ulyanovsk, Russia"
        cityLabel.textColor = .black
        return cityLabel
    }()

    private lazy var chartUIKitView: UIView = {
        let chartUIKitView = UIView()
        chartUIKitView.translatesAutoresizingMaskIntoConstraints = false
        chartUIKitView.backgroundColor = UIColor(red: 233/255, green: 258/255, blue: 250/255, alpha: 1)
        return chartUIKitView
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
        addSubview(chartUIKitView)
        addSubview(twentyFourOurTableView)


        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(48)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-130)
        }

        chartUIKitView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading)
            make.trailing.equalTo(safeArea.snp.trailing)
            make.height.equalTo(152)
        }

        twentyFourOurTableView.snp.makeConstraints { make in
            make.top.equalTo(chartUIKitView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(safeArea)
        }
    }

    func updateView(with model: [HourModel], mainModel: MainForecastsModels) {
        self.dataArray = model
        self.mainModel = mainModel
        cityLabel.text = "\((mainModel.locality)!), \((mainModel.country)!)"
        twentyFourOurTableView.reloadData()
        updateChart()
    }

    func updateChart() {
        var xValues = [HourModel]()
               for index in stride(from: 0, to: dataArray!.count, by: 3) {
                   let valueToAppend = dataArray![index]
                   xValues.append(valueToAppend)
               }
        let chartView = TempChartView()
        chartUIKitView.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.snp.makeConstraints { make in
            make.top.equalTo(chartUIKitView.snp.top)
            make.leading.equalTo(chartUIKitView.snp.leading)
            make.trailing.equalTo(chartUIKitView.snp.trailing)
            make.bottom.equalTo(chartUIKitView.snp.bottom)
        }

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
