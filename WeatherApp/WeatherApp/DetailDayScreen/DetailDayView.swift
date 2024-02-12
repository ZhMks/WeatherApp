//
//  DetailDayView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 09.02.2024.
//

import UIKit
import SnapKit

final class DetailDayView: UIView {

    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.showsVerticalScrollIndicator = true
        mainScrollView.isScrollEnabled = true
        return mainScrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.text = "Ulyanovsk, Russia"
        return cityLabel
    }()
    
    private lazy var dateCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(DetailDayCollectionViewCell.self, forCellWithReuseIdentifier: DetailDayTableViewCell.id)
        return dateCollectionView
    }()
    
    private lazy var dayNightTableView: UITableView = {
        let dayNightTableView = UITableView(frame: .zero, style: .insetGrouped)
        dayNightTableView.translatesAutoresizingMaskIntoConstraints = false
        dayNightTableView.delegate = self
        dayNightTableView.dataSource = self
        dayNightTableView.register(DetailDayTableViewCell.self, forCellReuseIdentifier: DetailDayTableViewCell.id)
        dayNightTableView.backgroundColor = .systemBackground
        return dayNightTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(mainScrollView)
        addSubview(dateCollectionView)
        addSubview(cityLabel)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(dayNightTableView)

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
        }

        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(40)
            make.leading.equalTo(cityLabel.snp.leading).offset(100)
            make.bottom.equalTo(mainScrollView.snp.top).offset(10)
        }

        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom)

        }

        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalTo(mainScrollView)
            make.bottom.equalTo(dayNightTableView.snp.bottom)
        }

        dayNightTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.height.equalTo(692)
            make.width.equalTo(344)
        }
    }
    
    
}


extension DetailDayView: UITableViewDelegate {}

extension DetailDayView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        341
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailDayTableViewCell.id, for: indexPath) as? DetailDayTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}


extension DetailDayView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailDayCollectionViewCell.id, for: indexPath) as? DetailDayCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemBlue
        return cell
    }
    


}
extension DetailDayView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
