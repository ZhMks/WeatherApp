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
    let tempChartView = TempChartView()


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
        tableView.separatorColor = .blue
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        return tableView
    }()

    private lazy var humidityCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let humidityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        humidityCollectionView.translatesAutoresizingMaskIntoConstraints = false
        humidityCollectionView.register(HumidityCollectionCell.self, forCellWithReuseIdentifier: HumidityCollectionCell.id)
        humidityCollectionView.backgroundColor = .clear
        humidityCollectionView.delegate = self
        return humidityCollectionView
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
        chartUIKitView.addSubview(tempChartView)
        chartUIKitView.addSubview(humidityCollectionView)

        tempChartView.translatesAutoresizingMaskIntoConstraints = false
        humidityCollectionView.translatesAutoresizingMaskIntoConstraints = false

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

        tempChartView.snp.makeConstraints { make in
            make.top.equalTo(chartUIKitView.snp.top).offset(5)
            make.leading.equalTo(chartUIKitView.snp.leading).offset(17)
            make.trailing.equalTo(chartUIKitView.snp.trailing).offset(-26)
            make.bottom.equalTo(chartUIKitView.snp.bottom).offset(-80)
        }

        humidityCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tempChartView.snp.bottom)
            make.leading.equalTo(chartUIKitView.snp.leading).offset(17)
            make.trailing.equalTo(chartUIKitView.snp.trailing)
            make.bottom.equalTo(chartUIKitView.snp.bottom)
        }
    }

    func updateView(with model: [HourModel], mainModel: MainForecastsModels, dataSource: UITableViewDataSource, collectionSource: UICollectionViewDataSource) {
        self.dataArray = model
        self.mainModel = mainModel
        cityLabel.text = "\((mainModel.locality)!), \((mainModel.country)!)"
        twentyFourOurTableView.dataSource = dataSource
        humidityCollectionView.dataSource = collectionSource
        tempChartView.updateView(data: model)
        twentyFourOurTableView.reloadData()
        humidityCollectionView.reloadData()
    }
}

extension DetailTwentyFourView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension DetailTwentyFourView: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 48, height: 80)
        }
}
