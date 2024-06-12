//
//  ForecastModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 15.02.2024.
//

import Foundation

final class HoursModelService {
    private(set) var hoursArray = [HourModel]()
    private let coreDataService = ForecastDataService.shared

    private let coreDataModel: ForecastModel

    init(coreDataModel: ForecastModel) {
        self.coreDataModel = coreDataModel
        fetchArrayFromCoreData()
    }

    private func fetchArrayFromCoreData() {
        guard let array = coreDataModel.hoursArray?.sortedArray(using: [NSSortDescriptor(key: "hour", ascending: true)]) as? [HourModel] else {
            self.hoursArray = []
            return
        }
        self.hoursArray = array
    }

}
