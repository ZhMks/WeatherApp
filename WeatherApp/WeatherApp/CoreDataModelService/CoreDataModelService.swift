import Foundation


final class CoreDataModelService {

    private(set) var modelArray: [MainForecastsModels]?
    let coreDataService = CoreDataService.shared


    init()
    {
        fetchFromCoreData()
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel) {
        guard let modelArray = modelArray else { return }

        if ((modelArray.first?.forecastArray?.contains(where: { ($0 as? ForecastModel)?.date == networkModel.forecast.first?.date })) != nil) {
            return
        } else {

            let newModelToSave = MainForecastsModels(context: coreDataService.managedContext)

            let components = networkModel.info.tzInfo.name.components(separatedBy: "/")

            let formattedString = "\(components[1]), \(components[0])"

            newModelToSave.name = formattedString

            saveForecast(networkModel: networkModel, mainModel: newModelToSave)

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

    private func saveForecast(networkModel: NetworkServiceModel, mainModel: MainForecastsModels) {

        for _ in networkModel.forecast {
            saveForecastModel(network: networkModel, mainModel: mainModel)
        }

        coreDataService.saveContext()
        fetchFromCoreData()
    }

    func saveForecastModel(network: NetworkServiceModel, mainModel: MainForecastsModels) {

        guard let context = mainModel.managedObjectContext else { return }

        for forecast in network.forecast {

            let newForecastModel = ForecastModel(context: context)

            saveHours(networkModel: forecast.hours, mainModelToSave: newForecastModel)
            save(day: forecast.partObj.day,
                 night: forecast.partObj.night,
                 dayShort: forecast.partObj.dayShort,
                 nightShort: forecast.partObj.nightShort,
                 mainModelToSave: newForecastModel)

            newForecastModel.date = forecast.date
            newForecastModel.moonCode = Int64(forecast.moonCode)
            newForecastModel.moonText = forecast.moonText
            newForecastModel.sunset = forecast.sunset
            newForecastModel.sunrise = forecast.sunrise
            mainModel.addToForecastArray(newForecastModel)
        }

    }

    func saveHours(networkModel: [HoursNetworkModel], mainModelToSave: ForecastModel) {

        guard let context = mainModelToSave.managedObjectContext else { return }

        for hour in networkModel {

            let hourModel = HourModel(context: context)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "ru")
            let date = Date(timeIntervalSince1970: TimeInterval(hour.hour))
            let localDate = dateFormatter.string(from: date)

            hourModel.hour = localDate

            hourModel.temp = Int64(hour.temp)
            hourModel.cloudness = hour.cloudness
            hourModel.feelsLike = Int64(hour.feelsLike)
            hourModel.precStr = hour.precStr
            hourModel.windSpeed = hour.windSpeed
            hourModel.windDir = hour.windDir
            hourModel.condition = hour.condition
            hourModel.uvIndex = Int64(hour.uvIndex)
            hourModel.humidity = Int64(hour.humidity)

            mainModelToSave.addToHoursArray(hourModel)
        }
    }

    func save(day: PartInfoNetworkModel, night: PartInfoNetworkModel, dayShort: ShortNetworkModel, nightShort: ShortNetworkModel, mainModelToSave: ForecastModel) {

        guard let context = mainModelToSave.managedObjectContext else { return }

        let newDayModel = DayModel(context: context)
        let newNightModel = NightModel(context: context)
        let newDayShortModel = DayShort(context: context)
        let newNightShortModel = NightShort(context: context)


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


        mainModelToSave.dayModel = newDayModel

        newNightModel.condition = night.condition
        newNightModel.dayTime = night.daytime
        newNightModel.feelsLike = Int64(night.feelsLike)
        newNightModel.humidity = Int64(night.humidity)
        newNightModel.precProb = Int64(night.precProb)
        newNightModel.tempAvg = Int64(night.tempAvg)
        newNightModel.tempMax = Int64(night.tempMax)
        newNightModel.tempMin = Int64(night.tempMin)
        newNightModel.windDir = day.windDir
        newNightModel.windSpeed = day.windSpeed

        mainModelToSave.nightModel = newNightModel

        newDayShortModel.condition = dayShort.condition
        newDayShortModel.dayTime = dayShort.daytime
        newDayShortModel.feelsLike = Int64(dayShort.feelsLike)
        newDayShortModel.humidity = Int64(dayShort.humidity)
        newDayShortModel.precProb = Int64(dayShort.precProb)
        newDayShortModel.temp = Int64(dayShort.temp)
        newDayShortModel.windDir = dayShort.windDir
        newDayShortModel.windSpeed = dayShort.windSpeed

        mainModelToSave.dayShort = newDayShortModel

        newNightShortModel.condition = nightShort.condition
        newNightShortModel.dayTime = nightShort.daytime
        newNightShortModel.feelsLike = Int64(nightShort.feelsLike)
        newNightShortModel.humidity = Int64(nightShort.humidity)
        newNightShortModel.precProb = Int64(nightShort.precProb)
        newNightShortModel.temp = Int64(nightShort.temp)
        newNightShortModel.windDir = nightShort.windDir
        newNightShortModel.windSpeed = nightShort.windSpeed

        mainModelToSave.nightShort = newNightShortModel

    }
}
