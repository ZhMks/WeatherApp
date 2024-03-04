

import Foundation
import UIKit


final class DataSourceForMainScreen: NSObject, UITableViewDataSource {

    var dataSource: [ForecastModel] = [] {
        didSet {
            print(dataSource.count)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EverydayForecastTableViewCell.id, for: indexPath) as? EverydayForecastTableViewCell else { return UITableViewCell() }
        let dataArray = dataSource[indexPath.row]
        cell.updateCellWith(model: dataArray)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func updateData(data: [ForecastModel] ) {
        self.dataSource = data
    }
}

final class DataSourceForMainCollectionCell: NSObject, UICollectionViewDataSource {

    var dataSource: [HourModel] = [] {
        didSet {
            print(dataSource.count)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        let dataFromArray = dataSource[indexPath.row]
        cell.updateCell(hour: dataFromArray)
        return cell
    }

    func updateData(data: [HourModel] ) {
        self.dataSource = data
    }
}


