//
//  ContentView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.03.2024.
//

import Foundation
import UIKit
import SnapKit

final class ContentView: UIView {
    private let blueView = UIView(frame: .zero)
    private let rightFooterView = FooterView(frame: .zero)
    private let leftFooterView = FooterView(frame: .zero)
    private let airConditionView = AirConditionView(frame: .zero)

    private lazy var dayNightTableView: UITableView = {
        let dayNightTableView = UITableView(frame: .zero, style: .insetGrouped)
        dayNightTableView.translatesAutoresizingMaskIntoConstraints = false
        dayNightTableView.register(DetailDayTableViewCell.self, forCellReuseIdentifier: DetailDayTableViewCell.id)
        dayNightTableView.backgroundColor = .clear
        dayNightTableView.isUserInteractionEnabled = false
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

    func configureTableView(dataSource: UITableViewDataSource) {
        self.dayNightTableView.dataSource = dataSource
        self.dayNightTableView.reloadData()
    }

    func reloadData() {
        self.dayNightTableView.reloadData()
    }

    private func addViews() {
        addSubview(dayNightTableView)
        addSubview(leftFooterView)
        addSubview(rightFooterView)
        addSubview(blueView)
        addSubview(airConditionView)
    }

    private func layout() {

        addViews()

        leftFooterView.translatesAutoresizingMaskIntoConstraints = false
        rightFooterView.translatesAutoresizingMaskIntoConstraints = false
        airConditionView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue
        rightFooterView.switchToNight()
        rightFooterView.createDottedLines()
        leftFooterView.createDottedLines()


        dayNightTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(760)
        }

        leftFooterView.snp.makeConstraints { make in
            make.top.equalTo(dayNightTableView.snp.bottom).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(blueView.snp.leading)
        }

        rightFooterView.snp.makeConstraints { make in
            make.top.equalTo(dayNightTableView.snp.bottom).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.leading.equalTo(blueView.snp.trailing)
        }

        blueView.snp.makeConstraints { make in
            make.leading.equalTo(leftFooterView.snp.trailing)
            make.trailing.equalTo(rightFooterView.snp.leading)
            make.top.equalTo(rightFooterView.snp.top).offset(35)
            make.bottom.equalTo(rightFooterView.snp.bottom)
            make.width.equalTo(1)
        }

        airConditionView.snp.makeConstraints { make in
            make.top.equalTo(leftFooterView.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(90)
        }
    }
}
