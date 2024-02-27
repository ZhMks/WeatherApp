//
//  ForecastModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 17.02.2024.
//

import Foundation


final class ForecastModelService {

    private let coreDataService = CoreDataService.shared

    private(set) var forecastModel: [ForecastModel]?

    private let coreDataModel: MainForecastsModels

    init (coreDataModel: MainForecastsModels) {
        self.coreDataModel = coreDataModel
        fetchData()
        updateCurrentForecastByDate()
    }

    func fetchData() {
        guard let array = coreDataModel.forecastArray?.sortedArray(using: [NSSortDescriptor(key: "date", ascending: true)]) as? [ForecastModel] else {
            self.forecastModel = []
            return
        }
        self.forecastModel = array
    }

    func delete(item: ForecastModel) {
        coreDataModel.managedObjectContext?.delete(item)
        coreDataService.saveContext()
        fetchData()
    }

    func convertSpeedValues() {
        if let userDefaultsValue = UserDefaults.standard.value(forKey: "distance") as? String {
            if userDefaultsValue == "Km" {
                var unitToConvert = Measurement(value: 0, unit: UnitSpeed.milesPerHour)
                var convertedUnit = unitToConvert.converted(to: .metersPerSecond).value

                for forecast in forecastModel! {
                    let hourModelService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourModelService.hoursArray
                    unitToConvert.value = (forecast.dayModel?.windSpeed)!
                    convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                    forecast.dayModel?.windSpeed = convertedUnit
                    unitToConvert.value = (forecast.nightModel?.windSpeed)!
                    convertedUnit = unitToConvert.converted(to: .metersPerSecond).value
                    forecast.nightModel?.windSpeed = convertedUnit

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
                    fetchData()
                }
            } else {
                var unitToConvert = Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
                var convertedUnit = unitToConvert.converted(to: .milesPerHour).value

                for forecast in forecastModel! {
                    let hourModelService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourModelService.hoursArray
                    unitToConvert.value = (forecast.dayModel?.windSpeed)!
                    convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                    forecast.dayModel?.windSpeed = convertedUnit
                    unitToConvert.value = (forecast.nightModel?.windSpeed)!
                    convertedUnit = unitToConvert.converted(to: .milesPerHour).value
                    forecast.nightModel?.windSpeed = convertedUnit

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
                    fetchData()
                }
            }
        }
    }

    func convertTempValues() {

        if let userDefaultsValue = UserDefaults.standard.value(forKey: "temperature") as? String {

            if userDefaultsValue == "C" {

                var unitToConvert = Measurement(value: 0, unit: UnitTemperature.fahrenheit)
                var convertedUnit = unitToConvert.converted(to: .celsius).value

                for forecast in forecastModel! {

                    let hourModelService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourModelService.hoursArray
                    unitToConvert.value = (forecast.dayModel?.tempAvg)!
                    convertedUnit = unitToConvert.converted(to: .celsius).value
                    forecast.dayModel?.tempAvg = convertedUnit

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

                    coreDataService.saveContext()
                    fetchData()
                }

            } else {

                var unitToConvert = Measurement(value: 0, unit: UnitTemperature.celsius)
                var convertedUnit = unitToConvert.converted(to: .fahrenheit).value

                for forecast in forecastModel! {

                    let hourModelService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourModelService.hoursArray
                    unitToConvert.value = (forecast.dayModel?.tempAvg)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.dayModel?.tempAvg = convertedUnit

                    unitToConvert.value = (forecast.dayModel?.tempMax)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.dayModel?.tempMax = convertedUnit

                    unitToConvert.value = (forecast.dayModel?.tempMin)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.dayModel?.tempMin = convertedUnit

                    unitToConvert.value = (forecast.nightModel?.tempAvg)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.nightModel?.tempAvg = convertedUnit


                    unitToConvert.value = (forecast.nightModel?.tempMax)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.nightModel?.tempMax = convertedUnit

                    unitToConvert.value = (forecast.nightModel?.tempMin)!
                    convertedUnit = unitToConvert.converted(to: .fahrenheit).value
                    forecast.nightModel?.tempMin = convertedUnit


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

                    coreDataService.saveContext()
                    fetchData()
                }
            }
        }

    }

    func convertHourFormat() {

        if let userDefaultsValue = UserDefaults.standard.value(forKey: "time") as? String  {

            let dateFormatter = DateFormatter()

            if userDefaultsValue == "24" {
                for forecast in forecastModel! {
                    let hourService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourService.hoursArray

                    dateFormatter.locale = Locale(identifier: "ru_RU")
                    for hour in hoursArray {
                        dateFormatter.dateFormat = "h:mm a"
                        if let dateFromString = dateFormatter.date(from: hour.hour!) {
                            dateFormatter.dateFormat = "HH:mm"
                            let convertedTime = dateFormatter.string(from: dateFromString)
                            print(convertedTime)
                            hour.hour = convertedTime
                            coreDataService.saveContext()
                            fetchData()
                        }

                    }
                }
            } else {
                for forecast in forecastModel! {
                    let hourService = HoursModelService(coreDataModel: forecast)
                    let hoursArray = hourService.hoursArray

                    dateFormatter.locale = Locale(identifier: "en_GB")
                    for hour in hoursArray {
                        dateFormatter.dateFormat = "HH:mm"
                        if let dateFromString = dateFormatter.date(from: hour.hour!) {
                            dateFormatter.dateFormat = "h:mm a"
                            let convertedTime = dateFormatter.string(from: dateFromString)
                            print(convertedTime)
                            hour.hour = convertedTime
                            coreDataService.saveContext()
                            fetchData()
                        }

                    }
                }
            }
        }
    }

    private func updateCurrentForecastByDate() {

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: currentDate)

        if let forecastModelsArray = forecastModel {
           for forecast in forecastModelsArray {
                if forecast.date! != stringDate {
                    delete(item: forecast)
                }
            fetchData()
            }
        }
    }
}

