//
//  DaysModelService.swift
//  WeatherApp
//
//  Created by Максим Жуин on 16.02.2024.
//

import Foundation

final class DaysModelService {

    private let coreDataService = CoreDataService.shared

    private(set) var dayModel: DayModel?
    private(set) var dayShortModel: DayShort?
    private(set) var nightModel: NightModel?
    private(set) var nightShortModel: NightShort?
    private let coreDataModel: ForecastModel

    init(coreDataModel: ForecastModel) {
        self.coreDataModel = coreDataModel
        fetchData()
    }

    private func fetchData() {
        guard let day = coreDataModel.dayModel else { return }
        guard let dayShort = coreDataModel.dayShort else { return }
        guard let night = coreDataModel.nightModel else { return }
        guard let nightShort = coreDataModel.nightShort else { return }

        self.dayModel = day
        self.dayShortModel = dayShort
        self.nightModel = night
        self.nightShortModel = nightShort

    }

}
