//
//  GeoLocationView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 25.02.2024.
//

import UIKit
import SnapKit

final class GeoLocationView: UIView {
    
    var geoVC: IGeoLocationVC?
    var coreDataModelService: MainForecastModelService?

    private var textFieldtext = ""
    
    private lazy var plusImage: UIButton = {
        let plusImage = UIButton(type: .system)
        plusImage.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        plusImage.tintColor = .black
        plusImage.clipsToBounds = true
        plusImage.translatesAutoresizingMaskIntoConstraints = false
        plusImage.addTarget(self, action: #selector(setGeoView(_:)), for: .touchUpInside)
        return plusImage
    }()
    
    private lazy var getLocationView: UIView = {
        let getLoactionView = UIView()
        getLoactionView.translatesAutoresizingMaskIntoConstraints = false
        getLoactionView.layer.borderWidth = 1
        getLoactionView.layer.borderColor = UIColor.black.cgColor
        getLoactionView.backgroundColor = .red
        getLoactionView.layer.cornerRadius = 10
        getLoactionView.backgroundColor = .systemBackground
        return getLoactionView
    }()
    
    private lazy var locationTextField: UITextField = {
        let locationTextField = UITextField()
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.placeholder = "Введите название"
        locationTextField.textColor = .black
        locationTextField.textAlignment = .left
        locationTextField.borderStyle = .roundedRect
        locationTextField.backgroundColor = .systemGray6
        locationTextField.delegate = self
        locationTextField.font = UIFont(name: "Rubik-Regular", size: 14)
        return locationTextField
    }()
    
    private lazy var notificationLabel: UILabel = {
        let notificationlabel = UILabel()
        notificationlabel.text = "Пожалуйста, введите желаемый адрес"
        notificationlabel.font = UIFont(name: "Rubik-Medium", size: 16)
        notificationlabel.numberOfLines = 0
        notificationlabel.textAlignment = .center
        notificationlabel.translatesAutoresizingMaskIntoConstraints = false
        return notificationlabel
    }()
    
    private lazy var getGeoDataButton: UIButton = {
        let getGeoDataButton = UIButton(type: .system)
        getGeoDataButton.translatesAutoresizingMaskIntoConstraints = false
        getGeoDataButton.setTitle("Установить", for: .normal)
        getGeoDataButton.tintColor = .white
        getGeoDataButton.layer.cornerRadius = 10.0
        getGeoDataButton.backgroundColor = UIColor(red: 242/255, green: 110/255, blue: 17/255, alpha: 1)
        getGeoDataButton.addTarget(self, action: #selector(getGeoData(_:)), for: .touchUpInside)
        return getGeoDataButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(plusImage)
        plusImage.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(90)
        }
    }

    func updateData(coreData: MainForecastModelService) {
        self.coreDataModelService = coreData
    }

    @objc private func setGeoView(_ sender: UIImageView) {
        addSubview(getLocationView)
        getLocationView.addSubview(notificationLabel)
        getLocationView.addSubview(locationTextField)
        getLocationView.addSubview(getGeoDataButton)
        
        getLocationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(220)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-250)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-30)
        }
        
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(getLocationView.snp.top).offset(10)
            make.leading.equalTo(getLocationView.snp.leading).offset(30)
            make.trailing.equalTo(getLocationView.snp.trailing).offset(-10)
            make.height.equalTo(80)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(20)
            make.leading.equalTo(getLocationView.snp.leading).offset(10)
            make.trailing.equalTo(getLocationView.snp.trailing).offset(-10)
        }
        
        getGeoDataButton.snp.makeConstraints { make in
            make.centerX.equalTo(getLocationView.snp.centerX)
            make.top.equalTo(locationTextField.snp.bottom).offset(10)
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
    }
    
    
    @objc private func getGeoData(_ sender: UIButton) {
        geoVC?.checkModelsArray(string: self.textFieldtext)
    }
}

extension GeoLocationView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldtext = textField.text!
        return true
    }
    
}
