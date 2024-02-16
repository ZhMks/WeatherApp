//
//  DaysModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 16.02.2024.
//

import Foundation

final class DaysModelService {

    private let coreDataService = CoreDataService.shared

    private(set) var dayModel: [DayModel]?
    private(set) var dayShortModel: [DayShort]?
    private(set) var nightModel: [NightModel]?
    private(set) var nightShortModel: [NightShort]?

    init() {
        fetchData()
    }

    private func fetchData() {
        let dayrequest = DayModel.fetchRequest()
        let dayShortRequest = DayShort.fetchRequest()
        let nightRequest = NightModel.fetchRequest()
        let nightShortRequest = NightShort.fetchRequest()

        do {
            dayModel = try coreDataService.managedContext.fetch(dayrequest)
            dayShortModel = try coreDataService.managedContext.fetch(dayShortRequest)
            nightModel = try coreDataService.managedContext.fetch(nightRequest)
            nightShortModel = try coreDataService.managedContext.fetch(nightShortRequest)
        } catch {
            dayModel = []
            dayShortModel = []
            nightModel = []
            nightShortModel = []
        }
    }

    func saveDays(model: ForecastModel, day: PartInfoNetworkModel, night: PartInfoNetworkModel, dayShort: ShortNetworkModel, nightShort: ShortNetworkModel) {
        let newDayModel = DayModel(context: coreDataService.managedContext)
        let newNightModel = NightModel(context: coreDataService.managedContext)
        let newDayShortModel = DayShort(context: coreDataService.managedContext)
        let newNightShortModel = NightShort(context: coreDataService.managedContext)

        newDayModel.condition = day.condition
        newDayModel.dayTime = day.daytime
        newDayModel.feelsLike = Int64(day.feelsLike)
        newDayModel.humidity = Int64(day.humidity)
        newDayModel.precProb = Int64(day.precProb)
        newDayModel.tempAvg = Int64(day.tempAvg)
        newDayModel.tempMax = Int64(day.tempMax)
        newDayModel.tempMin = Int64(day.tempMin)
        newDayModel.windDir = day.windDir
        newDayModel.windSpeed = day.windSpeed

        model.dayModel = newDayModel

        newNightModel.condition = night.condition
        newNightModel.dayTime = night.daytime
        newNightModel.feelsLike = Int64(night.feelsLike)
        newNightModel.humidity = Int64(night.humidity)
        newNightModel.precProb = Int64(night.precProb)
        newNightModel.tempAvg = Int64(night.tempAvg)
        newNightModel.tempMax = Int64(night.tempMax)
        newNightModel.tempMin = Int64(night.tempMin)
        newNightModel.windDir = night.windDir
        newNightModel.windSpeed = night.windSpeed

        model.nightModel = newNightModel

        newDayShortModel.condition = dayShort.condition
        newDayShortModel.dayTime = dayShort.daytime
        newDayShortModel.feelsLike = Int64(dayShort.feelsLike)
        newDayShortModel.humidity = Int64(dayShort.humidity)
        newDayShortModel.precProb = Int64(dayShort.precProb)
        newDayShortModel.temp = Int64(dayShort.temp)
        newDayShortModel.windDir = dayShort.windDir
        newDayShortModel.windSpeed = dayShort.windSpeed

        model.dayShort = newDayShortModel

        newNightShortModel.condition = nightShort.condition
        newNightShortModel.dayTime = nightShort.daytime
        newNightShortModel.feelsLike = Int64(nightShort.feelsLike)
        newNightShortModel.humidity = Int64(nightShort.humidity)
        newNightShortModel.precProb = Int64(nightShort.precProb)
        newNightShortModel.temp = Int64(nightShort.temp)
        newNightShortModel.windDir = nightShort.windDir
        newNightShortModel.windSpeed = nightShort.windSpeed

        model.nightShort = newNightShortModel

    }
}
