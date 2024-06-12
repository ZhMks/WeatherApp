//
//  DataSourceForTwentyFourHours.swift
//  WeatherApp
//
//  Created by Максим Жуин on 13.03.2024.
//

import Foundation
import UIKit


final class TableDataSourceForTwentyFour: NSObject, UITableViewDataSource {

    var dataSource: [HourModel] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TwentyFourHourTableViewCell.id, for: indexPath) as? TwentyFourHourTableViewCell else { return UITableViewCell()}
        let data = dataSource[indexPath.row]
        cell.updateCellWithData(model: data )
        return cell
    }

    func updateData(data: [HourModel] ) {
        self.dataSource = data
    }
}

final class DataSourceForHumidityCollection: NSObject, UICollectionViewDataSource {

    var dataSource: [HourModel] = [] 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumidityCollectionCell.id, for: indexPath) as? HumidityCollectionCell else { return UICollectionViewCell() }
        let dataFromArray = dataSource[indexPath.row]
        cell.updateData(data: dataFromArray)
        return cell
    }

    func updateData(data: [HourModel]) {
        self.dataSource = data
    }
}
