//
//  ForecastModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 17.02.2024.
//

import Foundation


final class ForecastModelService {

    private let coreDataService = ForecastDataService.shared

    private(set) var forecastModel: [ForecastModel]?

    private let coreDataModel: MainForecastsModels

    init (coreDataModel: MainForecastsModels) {
        self.coreDataModel = coreDataModel
        fetchData()
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
}

