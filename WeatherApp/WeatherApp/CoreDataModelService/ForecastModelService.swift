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

//    func updateCurrentForecastByDate() {
//
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let stringDate = dateFormatter.string(from: currentDate)
//
//        if let forecastModelArray = forecastModel {
//            guard let firstForecast = forecastModelArray.first else { return }
//            if stringDate != firstForecast.date! {
//                let firstElement = forecastModelArray.first { $0.date! != stringDate }
//                delete(item: firstElement!)
//                fetchData()
//            }
//        }
//    }
}

