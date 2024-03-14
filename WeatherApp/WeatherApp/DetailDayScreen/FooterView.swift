//
//  FooterView.swift
//  WeatherApp
//
//  Created by Максим Жуин on 11.03.2024.
//

import Foundation
import UIKit
import SnapKit


final class FooterView: UIView {
    private lazy var sunAndMoonLabel: UILabel = {
        let sunAndMoonLabel = UILabel()
        sunAndMoonLabel.font = UIFont(name: "Rubik-Regular", size: 18)
        sunAndMoonLabel.text = "Солнце и Луна"
        sunAndMoonLabel.textColor = .black
        sunAndMoonLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunAndMoonLabel
    }()

   private lazy var sunImage: UIImageView = {
        let sunImage = UIImageView()
        sunImage.image = UIImage(named: "UfLight")
        sunImage.translatesAutoresizingMaskIntoConstraints = false
        return sunImage
    }()

    private lazy var ellipseImage: UIImageView = {
        let moonImage = UIImageView()
        moonImage.image = UIImage(named: "Ellipse")
        moonImage.translatesAutoresizingMaskIntoConstraints = false
        return moonImage
    }()

    private lazy var moonStatusLabel: UILabel = {
        let moonStatusLabel = UILabel()
        moonStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        moonStatusLabel.text = "Полнолуние"
        moonStatusLabel.textColor = .black
        return moonStatusLabel
    }()

    private lazy var lightDayTimeLabel: UILabel = {
        let lightDayTimeLabel = UILabel()
        lightDayTimeLabel.text = "14ч 57мин"
        lightDayTimeLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        lightDayTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return lightDayTimeLabel
    }()

    private lazy var sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.text = "Восход"
        sunriseLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        sunriseLabel.textColor = .gray
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunriseLabel
    }()

    private lazy var sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        sunsetLabel.text = "Заход"
        sunsetLabel.textColor = .gray
        sunsetLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        return sunsetLabel
    }()

    private lazy var sunriseTime: UILabel = {
        let sunriseTime = UILabel()
        sunriseTime.text = "5:47"
        sunriseTime.font = UIFont(name: "Rubik-Regular", size: 14)
        sunriseTime.translatesAutoresizingMaskIntoConstraints = false
        return sunriseTime
    }()

    private lazy var sunsetTime: UILabel = {
        let sunsetTime = UILabel()
        sunsetTime.text = "20:20"
        sunsetTime.font = UIFont(name: "Rubik-Regular", size: 14)
        sunsetTime.translatesAutoresizingMaskIntoConstraints = false
        return sunsetTime
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        addSubview(sunAndMoonLabel)
        addSubview(sunImage)
        addSubview(lightDayTimeLabel)
        addSubview(sunriseLabel)
        addSubview(sunriseTime)
        addSubview(sunsetLabel)
        addSubview(sunsetTime)
    }

    private func layout() {

        addViews()

        sunAndMoonLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-50)
        }

        sunImage.snp.makeConstraints { make in
            make.top.equalTo(sunAndMoonLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.height.width.equalTo(23)

        }

        lightDayTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(sunAndMoonLabel.snp.bottom).offset(20)
            make.leading.equalTo(sunImage.snp.trailing).offset(70)
            make.trailing.equalTo(self.snp.trailing)
        }

        sunriseLabel.snp.makeConstraints { make in
            make.top.equalTo(sunImage.snp.bottom).offset(18)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-100)
        }

        sunriseTime.snp.makeConstraints { make in
            make.leading.equalTo(sunriseLabel.snp.trailing).offset(46)
            make.top.equalTo(sunImage.snp.bottom).offset(18)
            make.trailing.equalTo(self.snp.trailing)
        }

        sunsetLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseLabel.snp.bottom).offset(18)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-100)
        }

        sunsetTime.snp.makeConstraints { make in
            make.leading.equalTo(sunsetLabel.snp.trailing).offset(46)
            make.top.equalTo(sunriseTime.snp.bottom).offset(16)
            make.trailing.equalTo(self.snp.trailing)
        }
    }

    func switchToNight() {
        sunImage.image = UIImage(named: "MoonImage")

        addSubview(ellipseImage)
        addSubview(moonStatusLabel)

        ellipseImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(57)
            make.height.width.equalTo(15)
        }

        sunAndMoonLabel.text = ""
        moonStatusLabel.font = UIFont(name: "Rubik-Regular", size: 14)

        moonStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(ellipseImage.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing)
        }

        sunImage.snp.makeConstraints { make in
            make.top.equalTo(ellipseImage.snp.bottom).offset(27)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.height.width.equalTo(23)
        }

        sunriseLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-100)
        }
    }

    func createDottedLines() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 110))
        path.addLine(to: CGPoint(x: 180, y: 110))

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 2]
        shapeLayer.path = path.cgPath

        layer.addSublayer(shapeLayer)

        let secondPath = UIBezierPath()
        secondPath.move(to: CGPoint(x: 10, y: 75))
        secondPath.addLine(to: CGPoint(x: 180, y: 75))

        let secondShapeLayer = CAShapeLayer()
        secondShapeLayer.strokeColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        secondShapeLayer.lineWidth = 1
        secondShapeLayer.lineDashPattern = [4, 2]
        secondShapeLayer.path = secondPath.cgPath

        layer.addSublayer(secondShapeLayer)
    }

    func presentData() {
        
    }
}
