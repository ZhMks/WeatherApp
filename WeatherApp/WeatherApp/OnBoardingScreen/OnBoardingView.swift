//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

final class OnboardingView: UIView {

    // MARK: - Properties

    private lazy var accessGeoLabel: UILabel = {
        let accessLabel = UILabel()
        accessLabel.translatesAutoresizingMaskIntoConstraints = false
        accessLabel.font = UIFont(name: "Rubik-Bold", size: 16.0)
        accessLabel.numberOfLines = 0
        accessLabel.textAlignment = .center
        accessLabel.text = "Разрешить приложению  Weather использовать данные о местоположении устройства"
        accessLabel.textColor = .white
        return accessLabel
    }()

    private lazy var infoTextLabel: UILabel = {
        let infoTextLabel = UILabel()
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextLabel.font = UIFont(name: "Rubik-Medium", size: 14.0)
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textAlignment = .center
        infoTextLabel.text = """
Чтобы получить более точные прогнозы погоды во время движения или путешествия

Вы можете изменить свой выбор в любое время из меню приложения
"""
        infoTextLabel.textColor = .white
        return infoTextLabel
    }()


    lazy var accessGeoButton: UIButton = {
        let accessGeoButton = UIButton(type: .system)
        accessGeoButton.translatesAutoresizingMaskIntoConstraints = false
        accessGeoButton.backgroundColor = UIColor(red: 242/255, green: 110/255, blue: 17/255, alpha: 1)
        accessGeoButton.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 12.0)
        accessGeoButton.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        accessGeoButton.setTitleColor(.white, for: .normal)
        accessGeoButton.layer.cornerRadius = 8.0
        return accessGeoButton
    }()

    private lazy var ignoreGeoButton: UIButton = {
        let accessGeoButton = UIButton(type: .system)
        accessGeoButton.translatesAutoresizingMaskIntoConstraints = false
        accessGeoButton.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 12.0)
        accessGeoButton.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        accessGeoButton.setTitleColor(.white, for: .normal)
        return accessGeoButton
    }()

    private lazy var umbrellaImage: UIImageView = {
        let umbrellaImage = UIImageView(image: UIImage(named: "Umbrella"))
        umbrellaImage.translatesAutoresizingMaskIntoConstraints = false
        umbrellaImage.backgroundColor = .clear
        umbrellaImage.clipsToBounds = true
        return umbrellaImage
    }()

    private lazy var umbrellaImageShadow: UIImageView = {
        let umbrellaImageShadow = UIImageView(image: UIImage(named: "UmbrellaShadow"))
        umbrellaImageShadow.translatesAutoresizingMaskIntoConstraints = false
        umbrellaImageShadow.backgroundColor = .clear
        umbrellaImageShadow.clipsToBounds = true
        return umbrellaImageShadow
    }()

    private lazy var femaleBodyImage: UIImageView = {
        let femaleBodyImage = UIImageView(image: UIImage(named: "FemaleBody"))
        femaleBodyImage.translatesAutoresizingMaskIntoConstraints = false
        femaleBodyImage.backgroundColor = .clear
        femaleBodyImage.clipsToBounds = true
        return femaleBodyImage
    }()

    private lazy var scarfImage: UIImageView = {
        let scarfImage = UIImageView(image: UIImage(named: "Scarf"))
        scarfImage.translatesAutoresizingMaskIntoConstraints = false
        scarfImage.backgroundColor = .clear
        scarfImage.clipsToBounds = true
        return scarfImage
    }()

    private lazy var femaleFace: UIImageView = {
        let femaleFace = UIImageView(image: UIImage(named: "FemaleFace"))
        femaleFace.translatesAutoresizingMaskIntoConstraints = false
        femaleFace.backgroundColor = .clear
        femaleFace.clipsToBounds = true
        return femaleFace
    }()



    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func layout() {
        addSubview(accessGeoLabel)
        addSubview(infoTextLabel)
        addSubview(accessGeoButton)
        addSubview(ignoreGeoButton)
        addSubview(scarfImage)
        addSubview(femaleBodyImage)
        addSubview(umbrellaImageShadow)
        addSubview(femaleFace)
        addSubview(umbrellaImage)


        let safeArea = safeAreaLayoutGuide

        umbrellaImage.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(80)
            make.leading.trailing.equalTo(safeArea).inset(100)
            make.bottom.equalTo(accessGeoLabel.snp.top).offset(-120)
        }

        umbrellaImageShadow.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(85)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-101)
            make.leading.equalTo(safeArea.snp.leading).offset(107)
            make.bottom.equalTo(accessGeoLabel.snp.top).offset(-160)
        }

        femaleBodyImage.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(72)
            make.trailing.equalTo(safeArea).offset(-148)
            make.top.equalTo(safeArea).offset(152)
        }

        scarfImage.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(165)
            make.leading.equalTo(safeArea).offset(150)
            make.trailing.equalTo(safeArea).offset(-120)
        }

        femaleFace.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(120)
            make.leading.equalTo(safeArea).offset(140)
            make.trailing.equalTo(safeArea).offset(-200)
        }


        accessGeoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY)
            make.leading.equalTo(safeArea.snp.leading).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

        infoTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(accessGeoLabel.snp.centerX)
            make.top.equalTo(accessGeoLabel.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

        accessGeoButton.snp.makeConstraints { make in
            make.centerX.equalTo(infoTextLabel.snp.centerX)
            make.top.equalTo(infoTextLabel.snp.bottom).offset(25)
            make.leading.equalTo(safeArea.snp.leading).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

        ignoreGeoButton.snp.makeConstraints { make in
            make.top.equalTo(accessGeoButton.snp.top).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(150)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

    }
}
