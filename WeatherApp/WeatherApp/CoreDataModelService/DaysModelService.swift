//
//  DaysModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 16.02.2024.
//

import Foundation

final class DaysModelService {

    private let coreDataService = ForecastDataService.shared

    private(set) var dayModel: DayModel?
    private(set) var nightModel: NightModel?
    private let coreDataModel: ForecastModel

    init(coreDataModel: ForecastModel) {
        self.coreDataModel = coreDataModel
        fetchData()
    }

    private func fetchData() {
        guard let day = coreDataModel.dayModel else { return }
        guard let night = coreDataModel.nightModel else { return }

        self.dayModel = day
        self.nightModel = night
    }

}
