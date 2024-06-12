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

    func convertToKM() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

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
        }
    }

    func convertToMiles() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {
            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray
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

    func convertToFahrenheit() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            var unitToConvert = Measurement(value: 0, unit: UnitTemperature.celsius)
            var convertedUnit = unitToConvert.converted(to: .fahrenheit).value

            for forecast in array {

                unitToConvert.value = Double((forecast.dayModel?.tempAvg)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.dayModel?.tempAvg = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.tempMax)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.dayModel?.tempMax = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.tempMin)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.dayModel?.tempMin = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.feelsLike)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.dayModel?.feelsLike = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.tempAvg)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.nightModel?.tempAvg = Int16(convertedUnit)


                unitToConvert.value = Double((forecast.nightModel?.tempMax)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.nightModel?.tempMax = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.tempMin)!)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                forecast.nightModel?.tempMin = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.feelsLike)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.nightModel?.feelsLike = Int16(convertedUnit)
            }

            for hour in hoursArray {
                unitToConvert.value = Double(hour.temp)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                hour.temp = Int16(convertedUnit)

                unitToConvert.value = Double(hour.feelsLike)
                convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                hour.feelsLike = Int16(convertedUnit)
                do {
                    try hour.managedObjectContext?.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            coreDataService.saveContext()
        }
    }

    func convertToCelsius() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            var unitToConvert = Measurement(value: 0, unit: UnitTemperature.fahrenheit)
            var convertedUnit = unitToConvert.converted(to: .celsius).value

            for forecast in array {
                unitToConvert.value = Double((forecast.dayModel?.tempAvg)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.dayModel?.tempAvg = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.feelsLike)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.dayModel?.feelsLike = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.tempMax)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.dayModel?.tempMax = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.dayModel?.tempMin)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.dayModel?.tempMin = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.tempAvg)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.nightModel?.tempAvg = Int16(convertedUnit)


                unitToConvert.value = Double((forecast.nightModel?.tempMax)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.nightModel?.tempMax = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.tempMin)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.nightModel?.tempMin = Int16(convertedUnit)

                unitToConvert.value = Double((forecast.nightModel?.feelsLike)!)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                forecast.nightModel?.feelsLike = Int16(convertedUnit)
            }

            for hour in hoursArray {
                unitToConvert.value = Double(hour.temp)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                hour.temp = Int16(convertedUnit)


                unitToConvert.value = Double(hour.feelsLike)
                convertedUnit = unitToConvert.converted(to: .celsius).value
                hour.feelsLike = Int16(convertedUnit)

                do {
                    try hour.managedObjectContext?.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            coreDataService.saveContext()
        }
    }

    func convertTwelveHour() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourService.hoursArray


            let dateFormatter = DateFormatter()

            dateFormatter.locale = Locale(identifier: "en_GB")
            for hour in hoursArray {
                dateFormatter.dateFormat = "HH:mm"
                if let dateFromString = dateFormatter.date(from: hour.hour!) {
                    dateFormatter.dateFormat = "h:mm a"
                    let convertedTime = dateFormatter.string(from: dateFromString)
                    hour.hour = convertedTime
                }
            }
            coreDataService.saveContext()
        }
    }

    func convertTwentyFourHour() {

        guard let arrayOfMainModels = coreDataModelService.modelArray else { return }

        for model in arrayOfMainModels {

            let forecastService = ForecastModelService(coreDataModel: model)
            guard let array = forecastService.forecastModel else { return }
            guard let forecast = array.first else { return }
            let hourService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourService.hoursArray

            let dateFormatter = DateFormatter()

            dateFormatter.locale = Locale(identifier: "ru_RU")
            for hour in hoursArray {
                dateFormatter.dateFormat = "h:mm a"
                if let dateFromString = dateFormatter.date(from: hour.hour!) {
                    dateFormatter.dateFormat = "HH:mm"
                    let convertedTime = dateFormatter.string(from: dateFromString)
                    hour.hour = convertedTime
                }
            }
            coreDataService.saveContext()
        }
    }
}
