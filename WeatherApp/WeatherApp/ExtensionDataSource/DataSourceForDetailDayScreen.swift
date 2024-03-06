//
//  DataSourceForDetailDayScreen.swift
//  WeatherApp
//
//  Created by Максим Жуин on 05.03.2024.
//

import Foundation
import UIKit

final class TableDataSourceForDayNightScreen: NSObject, UITableViewDataSource {

    var dataSource: [HourModel] = [] 

    var forecast: ForecastModel?

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        341
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailDayTableViewCell.id, for: indexPath) as? DetailDayTableViewCell else { return UITableViewCell() }
        guard let forecast = forecast else { return  UITableViewCell() }
        if indexPath.section == 0 {
            cell.updateDayCellWith(data: forecast.dayModel!, hourArray: dataSource)
        } else {
            cell.updateNightCellWith(data: forecast.nightModel!, hourArray: dataSource)
        }
        return cell
    }

    func updateData(data: [HourModel], forecastModel: ForecastModel ) {
        self.dataSource = data
        self.forecast = forecastModel
    }
}

final class CollectionDataSourceFordayNightScreen: NSObject, UICollectionViewDataSource {

    var dataSource: [ForecastModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailDayCollectionViewCell.id, for: indexPath) as? DetailDayCollectionViewCell else { return UICollectionViewCell() }
        let data = dataSource[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }

    func updateData(data: [ForecastModel] ) {
        self.dataSource = data
    }
}
