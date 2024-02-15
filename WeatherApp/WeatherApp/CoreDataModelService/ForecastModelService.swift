//
//  ForecastModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 15.02.2024.
//

import Foundation

final class ForecastModelService {
    private(set) var forecastsArray: [ForecastModel]?
    private let coreDataService = CoreDataService.shared

    init() {
fetchArrayFromCoreData()
    }

    private func fetchArrayFromCoreData() {
        let request = ForecastModel.fetchRequest()
        do {
            forecastsArray = try coreDataService.managedContext.fetch(request)
            print(forecastsArray)
        } catch {
            print("CannotFetchArray from CoreData forecastsArray = []")
            forecastsArray = []
        }
    }
}
