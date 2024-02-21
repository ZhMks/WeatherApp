import Foundation


final class CoreDataModelService {

    private(set) var modelArray: [MainForecastsModels]?
    let coreDataService = CoreDataService.shared
    var newModelToSave: MainForecastsModels?


    init()
    {
        fetchFromCoreData()
        let modelToSave = MainForecastsModels(context: coreDataService.managedContext)
        self.newModelToSave = modelToSave
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel) {

        guard let modelArray = modelArray else { return }

        if modelArray.isEmpty {

            let components = networkModel.info.tzInfo.name.components(separatedBy: "/")

            let formattedString = "\(components[1]), \(components[0])"

            newModelToSave!.name = formattedString

            saveForecast(networkModel: networkModel, mainModel: newModelToSave!)

            coreDataService.saveContext()

            fetchFromCoreData()

        } else {
            guard let firstModel = modelArray.first else { return }
            let forecastService = ForecastModelService(coreDataModel: firstModel)
            guard let forecastArray = forecastService.forecastModel else { return }

            for networkForecast in networkModel.forecast {

                var isValuePresent = false

                for forecast in forecastArray {
                    print(forecast.date)
                    print(networkForecast.date)
                    if forecast.date! == networkForecast.date {
                        isValuePresent = true
                        print(isValuePresent)
                        break
                    }
                }

                if isValuePresent == false {

                    saveForecastModel(network: networkForecast, mainModel: (modelArray.first)!)

                    coreDataService.saveContext()

                    fetchFromCoreData()

                    print("SAVED isVALUEPRESETN")

                }
            }
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

        for forecast in networkModel.forecast {
            saveForecastModel(network: forecast, mainModel: mainModel)
        }

        coreDataService.saveContext()
        fetchFromCoreData()
    }

    func saveForecastModel(network: ForecastNetworkModel, mainModel: MainForecastsModels) {

        guard let context = mainModel.managedObjectContext else { return }

        let newForecastModel = ForecastModel(context: context)

        newForecastModel.date = network.date
        newForecastModel.moonCode = Int64(network.moonCode)
        newForecastModel.moonText = network.moonText
        newForecastModel.sunset = network.sunset
        newForecastModel.sunrise = network.sunrise
        mainModel.addToForecastArray(newForecastModel)

            saveHours(networkModel: network.hours, mainModelToSave: newForecastModel)
            save(day: network.partObj.day,
                 night: network.partObj.night,
                 dayShort: network.partObj.dayShort,
                 nightShort: network.partObj.nightShort,
                 mainModelToSave: newForecastModel)

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
            hourModel.condition = convertString(string: hour.condition)
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


        newDayModel.condition = convertString(string: day.condition)
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

        newNightModel.condition = convertString(string: night.condition)
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

        newDayShortModel.condition = convertString(string: dayShort.condition)
        newDayShortModel.dayTime = dayShort.daytime
        newDayShortModel.feelsLike = Int64(dayShort.feelsLike)
        newDayShortModel.humidity = Int64(dayShort.humidity)
        newDayShortModel.precProb = Int64(dayShort.precProb)
        newDayShortModel.temp = Int64(dayShort.temp)
        newDayShortModel.windDir = dayShort.windDir
        newDayShortModel.windSpeed = dayShort.windSpeed

        mainModelToSave.dayShort = newDayShortModel

        newNightShortModel.condition = convertString(string: nightShort.condition)
        newNightShortModel.dayTime = nightShort.daytime
        newNightShortModel.feelsLike = Int64(nightShort.feelsLike)
        newNightShortModel.humidity = Int64(nightShort.humidity)
        newNightShortModel.precProb = Int64(nightShort.precProb)
        newNightShortModel.temp = Int64(nightShort.temp)
        newNightShortModel.windDir = nightShort.windDir
        newNightShortModel.windSpeed = nightShort.windSpeed

        mainModelToSave.nightShort = newNightShortModel

    }

    func deleteForecast(model: ForecastModel) {

        let forecastSerivce = ForecastModelService(coreDataModel: (modelArray?.first)!)

        guard let forecastArray = forecastSerivce.forecastModel else { return }

        if let index = forecastArray.firstIndex(where: { $0 == model }) {
            forecastArray[index].managedObjectContext?.delete(model)
            coreDataService.saveContext()
        }

    }
}

extension CoreDataModelService {
    func convertString(string: String) -> String {
        var stringToSwitch = string
        switch stringToSwitch {
        case "clear":
            stringToSwitch = "Ясно"
            return stringToSwitch
        case "partly-cloudy":
            stringToSwitch = "Малооблачно"
            return stringToSwitch
        case "cloudy":
            stringToSwitch = "Облачно с прояснениями"
            return stringToSwitch
        case "overcast":
            stringToSwitch = "Пасмурно"
            return stringToSwitch
        case "light-rain":
            stringToSwitch = "Небольшой дождь"
            return stringToSwitch
        case "rain":
            stringToSwitch = "Дождь"
            return stringToSwitch
        case "heavy-rain":
            stringToSwitch = "Сильный дождь"
            return stringToSwitch
        case "showers":
            stringToSwitch = "Ливень"
            return stringToSwitch
        case "wet-snow":
            stringToSwitch = "Дождь со снегом"
            return stringToSwitch
        case "light-snow":
            stringToSwitch = "Небольшой снег"
            return stringToSwitch
        case "snow":
            stringToSwitch = "Снег"
            return stringToSwitch
        case "snow-showers":
            stringToSwitch = "Снегопад"
            return stringToSwitch
        case "hail":
            stringToSwitch = "Град"
            return stringToSwitch
        case "thunderstorm":
            stringToSwitch = "Гроза"
            return stringToSwitch
        case "thunderstorm-with-rain":
            stringToSwitch = "Дождь с грозой"
            return stringToSwitch
        case "thunderstorm-with-hail":
            stringToSwitch = "Гроза с градом"
            return stringToSwitch
        default:
            return string
        }
    }

}
