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
        return mainScrollView
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
        return dateCollectionView
    }()
    
    private lazy var dayNightTableView: UITableView = {
        let dayNightTableView = UITableView(frame: .zero, style: .insetGrouped)
        dayNightTableView.translatesAutoresizingMaskIntoConstraints = false
        dayNightTableView.delegate = self
        dayNightTableView.dataSource = self
        dayNightTableView.register(DetailDayTableViewCell.self, forCellReuseIdentifier: DetailDayTableViewCell.id)
        dayNightTableView.backgroundColor = .systemBackground
        dayNightTableView.isScrollEnabled = false
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
        mainScrollView.addSubview(dayNightTableView)

        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-15)
        }

        dayNightTableView.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.snp.top)
            make.leading.equalTo(mainScrollView.snp.leading)
            make.trailing.equalTo(mainScrollView.snp.trailing)
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
