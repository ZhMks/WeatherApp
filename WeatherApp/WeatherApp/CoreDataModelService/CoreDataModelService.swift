import Foundation


final class CoreDataModelService {

    private(set) var modelArray: [MainForecastsModels]?
    private let coreDataService = CoreDataService.shared

    init() {
        fetchFromCoreData()
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel) {

        saveHours(networkModel: networkModel)
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
            newModelToSave.addToForecastArray(newForecastModel)
        }
        coreDataService.saveContext()
        fetchFromCoreData()
    }

    private func saveHours(networkModel: NetworkServiceModel) {

        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray

        let initialArray = networkModel.forecast.map({ $0.hours })

        var i = 1

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

    private func saveDay(networkModel: NetworkServiceModel) {
        let newDayToSave = DayModel(context: coreDataService.managedContext)
        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray

        for forecast in networkModel.forecast {
            newDayToSave.condition = forecast.partObj.day.condition
            newDayToSave.dayTime = forecast.partObj.day.daytime
            newDayToSave.feelsLike = Int64(forecast.partObj.day.feelsLike)
            newDayToSave.humidity = Int64(forecast.partObj.day.humidity)
            newDayToSave.precProb = Int64(forecast.partObj.day.precProb)
            newDayToSave.tempAvg = Int64(forecast.partObj.day.tempAvg)
            newDayToSave.tempMax = Int64(forecast.partObj.day.tempMax)
            newDayToSave.tempMin = Int64(forecast.partObj.day.tempMin)
            newDayToSave.windDir = forecast.partObj.day.windDir
            newDayToSave.windSpeed = forecast.partObj.day.windSpeed

            for forecast in newModelToSave! {
                (forecast as? ForecastModel)?.dayModel = newDayToSave
            }
        }
    }

    private func saveNight(networkModel: NetworkServiceModel) {
        let newNightModel = NightModel(context: coreDataService.managedContext)
        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray

        for forecast in networkModel.forecast {
            newNightModel.condition = forecast.partObj.day.condition
            newNightModel.dayTime = forecast.partObj.day.daytime
            newNightModel.feelsLike = Int64(forecast.partObj.day.feelsLike)
            newNightModel.humidity = Int64(forecast.partObj.day.humidity)
            newNightModel.precProb = Int64(forecast.partObj.day.precProb)
            newNightModel.tempAvg = Int64(forecast.partObj.day.tempAvg)
            newNightModel.tempMax = Int64(forecast.partObj.day.tempMax)
            newNightModel.tempMin = Int64(forecast.partObj.day.tempMin)
            newNightModel.windDir = forecast.partObj.day.windDir
            newNightModel.windSpeed = forecast.partObj.day.windSpeed

            for forecast in newModelToSave! {
                (forecast as? ForecastModel)?.nightModel = newNightModel
            }
        }
    }

    private func saveDayShort(networkModel: NetworkServiceModel) {
        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray
        let newDayShortModel = DayShort(context: coreDataService.managedContext)

        for forecast in networkModel.forecast {
            newDayShortModel.condition = forecast.partObj.dayShort.condition
            newDayShortModel.dayTime = forecast.partObj.dayShort.daytime
            newDayShortModel.feelsLike = Int64(forecast.partObj.dayShort.feelsLike)
            newDayShortModel.humidity = Int64(forecast.partObj.dayShort.humidity)
            newDayShortModel.precProb = Int64(forecast.partObj.dayShort.precProb)
            newDayShortModel.temp = Int64(forecast.partObj.dayShort.temp)
            newDayShortModel.windDir = forecast.partObj.dayShort.windDir
            newDayShortModel.windSpeed = forecast.partObj.dayShort.windSpeed

            for forecast in newModelToSave! {
                (forecast as? ForecastModel)?.dayShort = newDayShortModel
            }
        }
    }

    private func saveNightShort(networkModel: NetworkServiceModel) {
        let newModelToSave = MainForecastsModels(context: coreDataService.managedContext).forecastArray
        let newNightShortModel = NightShort(context: coreDataService.managedContext)

        for forecast in networkModel.forecast {
            newNightShortModel.condition = forecast.partObj.dayShort.condition
            newNightShortModel.dayTime = forecast.partObj.dayShort.daytime
            newNightShortModel.feelsLike = Int64(forecast.partObj.dayShort.feelsLike)
            newNightShortModel.humidity = Int64(forecast.partObj.dayShort.humidity)
            newNightShortModel.precProb = Int64(forecast.partObj.dayShort.precProb)
            newNightShortModel.temp = Int64(forecast.partObj.dayShort.temp)
            newNightShortModel.windDir = forecast.partObj.dayShort.windDir
            newNightShortModel.windSpeed = forecast.partObj.dayShort.windSpeed

            for forecast in newModelToSave! {
                (forecast as? ForecastModel)?.nightShort = newNightShortModel
            }
        }
    }
}
