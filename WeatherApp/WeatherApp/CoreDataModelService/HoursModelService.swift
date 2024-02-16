//
//  ForecastModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 15.02.2024.
//

import Foundation

final class HoursModelService {
    private(set) var hoursArray: [HourModel]?
    private let coreDataService = CoreDataService.shared

    init() {
        fetchArrayFromCoreData()
    }

    private func fetchArrayFromCoreData() {
        let request = HourModel.fetchRequest()
        do {
            hoursArray = try coreDataService.managedContext.fetch(request)
        } catch {
            print("CannotFetchArray from CoreData forecastsArray = []")
            hoursArray = []
        }
    }

    func saveHourWith(model: ForecastModel, hoursArray: [HoursNetworkModel]) {

        for hour in hoursArray {
            let newHourModelToSave = HourModel(context: coreDataService.managedContext)
            newHourModelToSave.cloudness = hour.cloudness
            newHourModelToSave.condition = hour.condition
            newHourModelToSave.feelsLike = Int64(hour.feelsLike)
            newHourModelToSave.hour = hour.hour
            newHourModelToSave.humidity = Int64(hour.humidity)
            newHourModelToSave.precStr = hour.precStr
            newHourModelToSave.temp = Int64(hour.temp)
            newHourModelToSave.windDir = hour.windDir
            newHourModelToSave.windSpeed = hour.windSpeed
            newHourModelToSave.uvIndex = Int64(hour.uvIndex)

            model.addToHoursArray(newHourModelToSave)
        }

    }


}
