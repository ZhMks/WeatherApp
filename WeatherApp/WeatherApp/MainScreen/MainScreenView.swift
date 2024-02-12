//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import SnapKit
import UIKit
class MainScreenView: UIView {
    weak var mainScreenVC: IMainScreenController?

    private let mainWeatherView = WeatherView()

    private lazy var detailsTwentyFourHours: UIButton = {
        let details = UIButton(type: .system)
        details.translatesAutoresizingMaskIntoConstraints = false
        details.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 16)
        let attributedString = NSMutableAttributedString(string: "Подробнее на 24 часа")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))
        details.setTitleColor(.black, for: .normal)
        details.setAttributedTitle(attributedString, for: .normal)
        details.addTarget(self, action: #selector(tapOnTwentyFourButton(_:)), for: .touchUpInside)
        return details
    }()

    private lazy var weatherByTimeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        return weatherCollectionView
    }()

    private lazy var everydayForecastTableView: UITableView = {
        let everydayTableView = UITableView(frame: .zero, style: .insetGrouped)
        everydayTableView.translatesAutoresizingMaskIntoConstraints = false
        everydayTableView.dataSource = self
        everydayTableView.delegate = self
        everydayTableView.register(EverydayForecastTableViewCell.self,
                                   forCellReuseIdentifier: EverydayForecastTableViewCell.id)
        everydayTableView.backgroundColor = .clear
        return everydayTableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(mainWeatherView)
        addSubview(detailsTwentyFourHours)
        addSubview(weatherByTimeCollectionView)
        addSubview(everydayForecastTableView)
        let safeArea = safeAreaLayoutGuide
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false

        mainWeatherView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-450)
        }

        detailsTwentyFourHours.snp.makeConstraints { make in
            make.top.equalTo(mainWeatherView.snp.bottom).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-15)
        }

        weatherByTimeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(detailsTwentyFourHours.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(16)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-5)
            make.height.equalTo(120)
        }

        everydayForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(weatherByTimeCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.bottom.equalTo(safeArea.snp.bottom)
        }
    }

    @objc private func tapOnTwentyFourButton(_ sender: UIButton) {
        mainScreenVC?.pushTwentyFourVc()
    }
}

extension MainScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 48, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WeatherCollectionViewCell else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
            cell.weatherImage.transform = CGAffineTransform(scaleX: 2, y: 2)
            cell.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
            cell.temperatureLabel.textColor = .white
            cell.timeLabel.textColor = .white
        }
        UIView.animate(withDuration: 0.7, delay: 0.6) {
            cell.weatherImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension MainScreenView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 11 }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension MainScreenView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 4 }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 5 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EverydayForecastTableViewCell.id, for: indexPath) as? EverydayForecastTableViewCell else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MainScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainScreenVC?.pushDayNightVc()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}