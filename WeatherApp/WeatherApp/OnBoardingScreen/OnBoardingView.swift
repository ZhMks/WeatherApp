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

    weak var loginVC: IOnBoardingVC?

    private lazy var umbrellaView: UIView = {
        let umbrellaView = UIView()
        umbrellaView.translatesAutoresizingMaskIntoConstraints = false
        return umbrellaView
    }()

    private lazy var cloudImageView: UIImageView = {
        let cloudImageView = UIImageView(image: UIImage(named: "Cloud"))
        cloudImageView.translatesAutoresizingMaskIntoConstraints = false
        cloudImageView.backgroundColor = .clear
        return cloudImageView
    }()

    private lazy var halfCloudImageView: UIImageView = {
        let halfCloudImageView = UIImageView(image: UIImage(named: "HalfCloud"))
        halfCloudImageView.translatesAutoresizingMaskIntoConstraints = false
        halfCloudImageView.backgroundColor = .clear
        return halfCloudImageView
    }()

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
        infoTextLabel.font = UIFont(name: "Rubik-Regular", size: 14.0)
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
        accessGeoButton.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 12.0)
        accessGeoButton.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        accessGeoButton.setTitleColor(.white, for: .normal)
        accessGeoButton.layer.cornerRadius = 8.0
        return accessGeoButton
    }()

    private lazy var ignoreGeoButton: UIButton = {
        let accessGeoButton = UIButton(type: .system)
        accessGeoButton.translatesAutoresizingMaskIntoConstraints = false
        accessGeoButton.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 12.0)
        accessGeoButton.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        accessGeoButton.setTitleColor(.white, for: .normal)
        accessGeoButton.addTarget(self, action: #selector(ignoreGeoButtonTappe(_:)), for: .touchUpInside)
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

    private lazy var backHair: UIImageView = {
        let backHair = UIImageView(image: UIImage(named: "BackHair"))
        backHair.translatesAutoresizingMaskIntoConstraints = false
        backHair.backgroundColor = .clear
        backHair.clipsToBounds = true
        return backHair
    }()

    private lazy var femaleView: UIView = {
        let femaleView = UIView()
        femaleView.translatesAutoresizingMaskIntoConstraints = false
        return femaleView
    }()



    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        animateView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: -LAYOUT

    private func layout() {

        createViews()

        let safeArea = safeAreaLayoutGuide

        umbrellaView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(60)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-50)
            make.top.equalTo(safeArea.snp.top).offset(110)
            make.bottom.equalTo(accessGeoLabel.snp.top).offset(-80)
        }

        umbrellaImage.snp.makeConstraints { make in
            make.top.equalTo(umbrellaView.snp.top)
            make.leading.trailing.equalTo(umbrellaView).inset(50)
            make.bottom.equalTo(umbrellaView.snp.bottom).offset(-50)
        }

        umbrellaImageShadow.snp.makeConstraints { make in
            make.top.equalTo(umbrellaView.snp.top)
            make.trailing.equalTo(umbrellaView.snp.trailing).offset(-50)
            make.leading.equalTo(umbrellaView.snp.leading).offset(55)
            make.bottom.equalTo(umbrellaView.snp.bottom).offset(-90)
        }

        femaleView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(110)
            make.leading.equalTo(safeArea.snp.leading).offset(60)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-50)
            make.bottom.equalTo(accessGeoLabel.snp.top).offset(-60)
        }

        scarfImage.snp.makeConstraints { make in
            make.top.equalTo(femaleView.snp.top).offset(70)
            make.leading.equalTo(femaleView.snp.leading).offset(120)
            make.trailing.equalTo(femaleView.snp.trailing).offset(-80)
            make.bottom.equalTo(femaleView.snp.bottom).offset(-90)
        }

        femaleBodyImage.snp.makeConstraints { make in
            make.top.equalTo(femaleView.snp.top).offset(55)
            make.leading.equalTo(femaleView.snp.leading).offset(47)
            make.trailing.equalTo(femaleView.snp.trailing).offset(-128)
            make.bottom.equalTo(femaleView.snp.bottom).offset(-35)
        }

        femaleFace.snp.makeConstraints { make in
            make.top.equalTo(umbrellaView.snp.top).offset(40)
            make.leading.equalTo(umbrellaView.snp.leading).offset(75)
            make.trailing.equalTo(umbrellaView.snp.trailing).offset(-150)
            make.bottom.equalTo(umbrellaView.snp.bottom).offset(-110)
        }

        backHair.snp.makeConstraints { make in
            make.top.equalTo(femaleView.snp.top).offset(45)
            make.leading.equalTo(femaleView.snp.leading).offset(100)
            make.trailing.equalTo(femaleView.snp.trailing).offset(-110)
            make.bottom.equalTo(femaleView.snp.bottom).offset(-110)
        }

        accessGeoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(400)
            make.bottom.equalTo(infoTextLabel.snp.top).offset(-35)
            make.leading.equalTo(safeArea.snp.leading).offset(25)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

        infoTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(accessGeoLabel.snp.centerX)
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
            make.top.equalTo(accessGeoButton.snp.bottom).offset(20)
            make.leading.equalTo(safeArea.snp.leading).offset(150)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }

        cloudImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(80)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-30)
        }

        halfCloudImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top)
            make.leading.equalTo(safeArea.snp.leading).offset(-10)
        }

    }

    private func createViews() {
        addSubview(accessGeoLabel)
        addSubview(infoTextLabel)
        addSubview(accessGeoButton)
        addSubview(ignoreGeoButton)
        addSubview(femaleView)
        addSubview(cloudImageView)
        addSubview(halfCloudImageView)
        femaleView.addSubview(scarfImage)
        addSubview(umbrellaView)
        umbrellaView.addSubview(umbrellaImageShadow)
        femaleView.addSubview(backHair)
        umbrellaView.addSubview(femaleFace)
        umbrellaView.addSubview(umbrellaImage)
        femaleView.addSubview(femaleBodyImage)

        accessGeoButton.addTarget(self, action: #selector(accessGeoButtonTapped(_:)), for: .touchUpInside)
    }

    private func animateView() {
        UIView.animate(withDuration: 1.0, delay: 0.0,options: [.repeat, .autoreverse, .curveLinear]) { [weak self] in
            guard let self else { return }
            femaleFace.transform = CGAffineTransform(translationX: 2, y: 0)
            femaleFace.transform = CGAffineTransform(translationX: 0, y: 3)
            backHair.transform = CGAffineTransform(translationX: 8, y: 0)
            backHair.transform = CGAffineTransform(translationX: 0, y: 5)
            femaleBodyImage.transform = CGAffineTransform(translationX: 3, y: 0)
            femaleBodyImage.transform = CGAffineTransform(translationX: 0, y: 10)
            umbrellaView.transform = CGAffineTransform(translationX: 3, y: 0)
            umbrellaView.transform = CGAffineTransform(translationX: 0, y: 10)
            scarfImage.transform = CGAffineTransform(translationX: 10, y: 0)
            scarfImage.transform = CGAffineTransform(translationX: 0, y: 8)
        }
        UIView.animate(withDuration: 8.0, delay: 0.0, options: [.curveLinear, .repeat]) { [weak self] in
            guard let self else { return }
            cloudImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1.3, y: 0)
            cloudImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * 1.3, y: 0)
        }

    }

    // MARK: -FUNCS
    
    @objc private func accessGeoButtonTapped(_ sender: UIButton) {
        loginVC?.requestAuthorisation()
    }

    @objc private func ignoreGeoButtonTappe(_ sender: UIButton) {
        loginVC?.pushGeoVC()
    }
}
