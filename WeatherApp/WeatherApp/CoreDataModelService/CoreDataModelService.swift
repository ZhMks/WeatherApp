//
//  CoreDataModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 13.02.2024.
//

import Foundation


final class CoreDataModelService {
    private(set) var modelsArray = [MainForeCastModel]()

    private let coreDataService = CoreDataService.shared

    func saveModel(networkModel: NetworkServiceModel) {
        let newInfoModel = InfoModel(context: coreDataService.managedContext)
        let newModelToSave = MainForeCastModel(context: coreDataService.managedContext)
        let newFactModel = FactModel(context: coreDataService.managedContext)



        newFactModel.cloudness = networkModel.fact.cloudness
        newFactModel.condition = networkModel.fact.condition
        newFactModel.dayTime = networkModel.fact.daytime
        newFactModel.feelsLike = Int64(networkModel.fact.feelsLike)
        newFactModel.humidity = Int64(networkModel.fact.humidity)
        newFactModel.precType = Int64(networkModel.fact.precType)
        newFactModel.temp = Int64(networkModel.fact.temp)
        newFactModel.windDir = networkModel.fact.windDir
        newFactModel.windSpeed = networkModel.fact.windSpeed

        newInfoModel.lat = networkModel.info.lat
        newInfoModel.lon = networkModel.info.lon
        newInfoModel.name = networkModel.info.tzInfo.name


        networkModel.forecast.forEach { forecast in
            let newForecastModel = ForecastModel(context: coreDataService.managedContext)
            let newDayModel = DayModel(context: coreDataService.managedContext)
            let newNightModel = NightModel(context: coreDataService.managedContext)
            let newDayShortModel = DayShortModel(context: coreDataService.managedContext)
            let newNightShortModel = NightShortModel(context: coreDataService.managedContext)

            newForecastModel.date = forecast.date
            newForecastModel.mooncode = Int64(forecast.moonCode)
            newForecastModel.moontext = forecast.moonText
            newForecastModel.sunrise = forecast.sunrise
            newForecastModel.sunset = forecast.sunset
            newForecastModel.week = Int64(forecast.week)
            newModelToSave.addToForecastModel(newForecastModel)

            newDayModel.condition = forecast.partObj.day.condition
            newDayModel.dayTime = forecast.partObj.day.daytime
            newDayModel.feelsLike = Int64(forecast.partObj.day.feelsLike)
            newDayModel.humidity = Int64(forecast.partObj.day.humidity)
            newDayModel.precProb = Int64(forecast.partObj.day.precProb)
            newDayModel.tempMax = Int64(forecast.partObj.day.tempMax)
            newDayModel.tempMin = Int64(forecast.partObj.day.tempMin)
            newDayModel.windDir = forecast.partObj.day.windDir
            newDayModel.windSpeed = forecast.partObj.day.windSpeed

            newNightModel.condition = forecast.partObj.night.condition
            newNightModel.dayTime = forecast.partObj.night.daytime
            newNightModel.feelsLike = Int64(forecast.partObj.night.feelsLike)
            newNightModel.humidity = Int64(forecast.partObj.night.humidity)
            newNightModel.precProb = Int64(forecast.partObj.night.precProb)
            newNightModel.tempMax = Int64(forecast.partObj.night.tempMax)
            newNightModel.tempMin = Int64(forecast.partObj.night.tempMin)
            newNightModel.windDir = forecast.partObj.night.windDir
            newNightModel.windSpeed = forecast.partObj.night.windSpeed

            newDayShortModel.condition = forecast.partObj.dayShort.condition
            newDayShortModel.dayTime = forecast.partObj.dayShort.daytime
            newDayShortModel.feelsLike = Int64(forecast.partObj.dayShort.feelsLike)
            newDayShortModel.humidity = Int64(forecast.partObj.dayShort.humidity)
            newDayShortModel.precProb = Int64(forecast.partObj.dayShort.precProb)
            newDayShortModel.temp = Int64(forecast.partObj.dayShort.temp)
            newDayShortModel.windDir = forecast.partObj.dayShort.windDir
            newDayShortModel.windSpeed = forecast.partObj.dayShort.windSpeed

            newNightShortModel.condition = forecast.partObj.nightShort.condition
            newNightShortModel.dayTime = forecast.partObj.nightShort.daytime
            newNightShortModel.feelsLike = Int64(forecast.partObj.nightShort.feelsLike)
            newNightShortModel.humidity = Int64(forecast.partObj.nightShort.humidity)
            newNightShortModel.precProb = Int64(forecast.partObj.nightShort.precProb)
            newNightShortModel.temp = Int64(forecast.partObj.nightShort.temp)
            newNightShortModel.windDir = forecast.partObj.nightShort.windDir
            newNightShortModel.windSpeed = forecast.partObj.nightShort.windSpeed

            newModelToSave.partsObj?.addToDayModel(newDayModel)
            newModelToSave.partsObj?.addToDayShortModel(newDayShortModel)
            newModelToSave.partsObj?.addToNightModel(newNightModel)
            newModelToSave.partsObj?.addToNightShortModel(newNightShortModel)

            print("Count of newModel: \(newModelToSave.partsObj?.dayModel?.count)")
            print("count of forecast: \(newModelToSave.forecastModel?.count)")

        }

        networkModel.forecast.forEach { forecast in
            forecast.hours.forEach { hour in
                let newHourModel = HourModel(context: coreDataService.managedContext)
                newHourModel.cloudness = hour.cloudness
                newHourModel.condition = hour.condition
                newHourModel.feelsLike = Int64(hour.feelsLike)
                newHourModel.hour = hour.hour
                newHourModel.humidity = Int64(hour.humidity)
                newHourModel.precStr = Int64(hour.precStr)
                newHourModel.temp = Int64(hour.temp)
                newHourModel.uvIndex = Int64(hour.uvIndex)
                newHourModel.windDir = hour.windDir
                newHourModel.windSpeed = hour.windSpeed
            }
        }

        newModelToSave.factModel = newFactModel
        newModelToSave.infoModel = newInfoModel

        print(newModelToSave.partsObj?.dayModel?.count)
        print(newModelToSave.partsObj?.nightModel?.count)
        print(newModelToSave.partsObj?.dayShortModel?.count)
        print(newModelToSave.partsObj?.nightShortModel?.count)

        coreDataService.saveContext()
    }

    init() {
        fetchFromCoreData()
    }

    private func fetchFromCoreData() {
        let request = MainForeCastModel.fetchRequest()

        do {
            modelsArray = try coreDataService.managedContext.fetch(request)
        } catch {
            modelsArray = []
        }
    }
}
