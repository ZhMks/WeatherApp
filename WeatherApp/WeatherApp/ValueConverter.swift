//
//  ValueConverter.swift
//  WeatherApp
//
//  Created by Максим Жуин on 02.03.2024.
//

import Foundation


final class ValueConverter {
    static let shared = ValueConverter()
    let coreDataService = ForecastDataService.shared
    let coreDataModelService = MainForecastModelService()
    private init() {}

    func convertSpeedValues() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            if let userDefaultsValue = UserDefaults.standard.value(forKey: "distance") as? String {
                if userDefaultsValue == "Km" {
                    var unitToConvert = Measurement(value: 0, unit: UnitSpeed.milesPerHour)
                    var convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                    for forecast in array {
                        unitToConvert.value = (forecast.dayModel?.windSpeed)!
                        convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                        forecast.dayModel?.windSpeed = convertedUnit
                        unitToConvert.value = (forecast.nightModel?.windSpeed)!
                        convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                        forecast.nightModel?.windSpeed = convertedUnit
                    }
                    for hour in hoursArray {
                        unitToConvert.value = hour.windSpeed
                        convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                        hour.windSpeed = convertedUnit
                        do {
                            try hour.managedObjectContext?.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    coreDataService.saveContext()

                } else {
                    var unitToConvert = Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
                    var convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                    for forecast in array {
                        unitToConvert.value = (forecast.dayModel?.windSpeed)!
                        convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                        forecast.dayModel?.windSpeed = convertedUnit
                        unitToConvert.value = (forecast.nightModel?.windSpeed)!
                        convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                        forecast.nightModel?.windSpeed = convertedUnit
                    }
                    for hour in hoursArray {
                        unitToConvert.value = hour.windSpeed
                        convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                        hour.windSpeed = convertedUnit
                        do {
                            try hour.managedObjectContext?.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    coreDataService.saveContext()
                }
            }
        }
    }

    func convertTempValues() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            if let userDefaultsValue = UserDefaults.standard.value(forKey: "temperature") as? String {

                if userDefaultsValue == "C" {

                    var unitToConvert = Measurement(value: 0, unit: UnitTemperature.fahrenheit)
                    var convertedUnit = unitToConvert.converted(to: .celsius).value

                    for forecast in array {
                        unitToConvert.value = (forecast.dayModel?.tempAvg)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.dayModel?.tempAvg = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.feelsLike)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.dayModel?.feelsLike = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.tempMax)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.dayModel?.tempMax = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.tempMin)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.dayModel?.tempMin = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.tempAvg)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.nightModel?.tempAvg = convertedUnit


                        unitToConvert.value = (forecast.nightModel?.tempMax)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.nightModel?.tempMax = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.tempMin)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.nightModel?.tempMin = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.feelsLike)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.nightModel?.feelsLike = convertedUnit
                    }

                    for hour in hoursArray {
                        unitToConvert.value = hour.temp
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        hour.temp = convertedUnit


                        unitToConvert.value = hour.feelsLike
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        hour.feelsLike = convertedUnit

                        do {
                            try hour.managedObjectContext?.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } else {

                    var unitToConvert = Measurement(value: 0, unit: UnitTemperature.celsius)
                    var convertedUnit = unitToConvert.converted(to: .fahrenheit).value

                    for forecast in array {

                        unitToConvert.value = (forecast.dayModel?.tempAvg)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.dayModel?.tempAvg = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.tempMax)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.dayModel?.tempMax = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.tempMin)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.dayModel?.tempMin = convertedUnit

                        unitToConvert.value = (forecast.dayModel?.feelsLike)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.dayModel?.feelsLike = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.tempAvg)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.nightModel?.tempAvg = convertedUnit


                        unitToConvert.value = (forecast.nightModel?.tempMax)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.nightModel?.tempMax = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.tempMin)!
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        forecast.nightModel?.tempMin = convertedUnit

                        unitToConvert.value = (forecast.nightModel?.feelsLike)!
                        convertedUnit = unitToConvert.converted(to: .celsius).value
                        forecast.nightModel?.feelsLike = convertedUnit
                    }

                    for hour in hoursArray {
                        unitToConvert.value = hour.temp
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        hour.temp = convertedUnit

                        unitToConvert.value = hour.feelsLike
                        convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                        hour.feelsLike = convertedUnit
                        do {
                            try hour.managedObjectContext?.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                coreDataService.saveContext()

            }
        }
    }

    func convertHourFormat() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourService.hoursArray

            if let userDefaultsValue = UserDefaults.standard.value(forKey: "time") as? String  {

                let dateFormatter = DateFormatter()

                if userDefaultsValue == "24" {
                    dateFormatter.locale = Locale(identifier: "ru_RU")
                    for hour in hoursArray {
                        dateFormatter.dateFormat = "h:mm a"
                        if let dateFromString = dateFormatter.date(from: hour.hour!) {
                            dateFormatter.dateFormat = "HH:mm"
                            let convertedTime = dateFormatter.string(from: dateFromString)
                            print(convertedTime)
                            hour.hour = convertedTime
                        }
                    }
                } else {
                    dateFormatter.locale = Locale(identifier: "en_GB")
                    for hour in hoursArray {
                        dateFormatter.dateFormat = "HH:mm"
                        if let dateFromString = dateFormatter.date(from: hour.hour!) {
                            dateFormatter.dateFormat = "h:mm a"
                            let convertedTime = dateFormatter.string(from: dateFromString)
                            print(convertedTime)
                            hour.hour = convertedTime
                        }
                    }
                }
                coreDataService.saveContext()
            }
        }
    }
}
