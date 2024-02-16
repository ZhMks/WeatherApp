import Foundation


final class CoreDataModelService {

    private(set) var modelArray: [MainForecastsModels]?
     let coreDataService = CoreDataService.shared
     let hoursModelService: HoursModelService
     let daysModelService: DaysModelService

    init(hoursMdService: HoursModelService, daysMdService: DaysModelService) {
        self.hoursModelService = hoursMdService
        self.daysModelService = daysMdService
        fetchFromCoreData()
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel) {
        guard let modelArray = modelArray else { return }

        if ((modelArray.first?.forecastArray?.contains(where: { ($0 as? ForecastModel)?.date == networkModel.forecast.first?.date })) != nil) {
            return
        } else {
            saveForecast(networkModel: networkModel)

            coreDataService.saveContext()

            fetchFromCoreData()
        }
    }

    private func fetchFromCoreData() {
        let request = MainForecastsModels.fetchRequest()
        do {
            modelArray = try coreDataService.managedContext.fetch(request)
        } catch {
            modelArray = []
            print("Cannot fetch data from CoreData modelsArray = []")
        }
    }

    private func saveForecast(networkModel: NetworkServiceModel) {
        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext)

        newModelToSave.name = networkModel.info.tzInfo.name

        for forecast in networkModel.forecast {
         
            let newForecastModel = ForecastModel(context: coreDataService.managedContext)

            hoursModelService.saveHourWith(model: newForecastModel, hoursArray: forecast.hours)
            daysModelService.saveDays(model: newForecastModel,
                                      day: forecast.partObj.day,
                                      night: forecast.partObj.night,
                                      dayShort: forecast.partObj.dayShort,
                                      nightShort: forecast.partObj.nightShort)

            newForecastModel.date = forecast.date
            newForecastModel.moonCode = Int64(forecast.moonCode)
            newForecastModel.moonText = forecast.moonText
            newForecastModel.sunset = forecast.sunset
            newForecastModel.sunrise = forecast.sunrise
            newModelToSave.addToForecastArray(newForecastModel)
        }
        coreDataService.saveContext()
        fetchFromCoreData()
    }
}
