import Foundation


final class CoreDataModelService {

    private(set) var modelArray: [MainForecastsModels]?
    private let coreDataService = CoreDataService.shared

    init() {
        fetchFromCoreData()
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel) {

        saveHours(networkModel: networkModel)
        saveForecast(networkModel: networkModel)
//        saveDay(networkModel: networkModel)
//        saveNight(networkModel: networkModel)
//        saveDayShort(networkModel: networkModel)
//        saveNightShort(networkModel: networkModel)

//        guard let modelArray = modelArray else { return }
//
//        if ((modelArray.first?.forecastArray?.contains(where: { ($0 as? ForecastModel)?.date == networkModel.forecast.first?.date })) != nil) {
//            print("contains")
//            return
//        } else {
//            saveForecast(networkModel: networkModel)
//
//            let newModelToSave = MainForecastsModels(context: coreDataService.managedContext)
//
//            newModelToSave.name = networkModel.info.tzInfo.name
//
//            coreDataService.saveContext()
//
//            fetchFromCoreData()
//        }
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

        for forecast in networkModel.forecast {

            let newForecastModel = ForecastModel(context: coreDataService.managedContext)
            newForecastModel.date = forecast.date
            newForecastModel.moonCode = Int64(forecast.moonCode)
            newForecastModel.moonText = forecast.moonText
            newForecastModel.sunset = forecast.sunset
            newForecastModel.sunrise = forecast.sunrise
            for model in forecast.hours {
                let newHour = HourModel(context: coreDataService.managedContext)
                newHour.cloudness = model.cloudness
                newForecastModel.addToHoursArray(newHour)
            }
            newModelToSave.addToForecastArray(newForecastModel)
        }
        coreDataService.saveContext()
        fetchFromCoreData()
    }

    private func saveHours(networkModel: NetworkServiceModel) {

        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray

        let initialArray = networkModel.forecast.map({ $0.hours })

        for hoursArray in initialArray {
            for element in hoursArray {
                for forecast in newModelToSave! {
                    let newHourModel = HourModel(context: coreDataService.managedContext)
                    newHourModel.cloudness = element.cloudness
                    newHourModel.condition = element.condition
                    newHourModel.feelsLike = Int64(element.feelsLike)
                    newHourModel.hour = element.hour
                    newHourModel.humidity = Int64(element.humidity)
                    newHourModel.precStr = element.precStr
                    newHourModel.temp = Int64(element.temp)
                    newHourModel.uvIndex = Int64(element.uvIndex)
                    newHourModel.windDir = element.windDir
                    newHourModel.windSpeed = element.windSpeed
                    (forecast as? ForecastModel)?.addToHoursArray(newHourModel)
                }
            }
        }
    }
}
