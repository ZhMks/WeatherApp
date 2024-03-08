import Foundation


enum ErrorsInSaving: Error {
    case alreadyExist

    var description: String {
        switch self {
        case .alreadyExist: return "Город уже был добавлен"
        }
    }
}



final class MainForecastModelService {

    private(set) var modelArray: [MainForecastsModels]?
    let coreDataService = ForecastDataService.shared



    init()
    {
        fetchFromCoreData()
    }

    func saveModelToCoreData(networkModel: NetworkServiceModel, completion: @escaping (Result<MainForecastsModels, ErrorsInSaving>) -> Void) {

        guard let modelArray = modelArray else { return }

                if modelArray.isEmpty {
                let modelToSave = MainForecastsModels(context: coreDataService.managedContext)
                modelToSave.locality = networkModel.geoObject.locality.name
                modelToSave.country = networkModel.geoObject.country.name
                saveForecast(networkModel: networkModel, mainModel: modelToSave)
                coreDataService.saveContext()
                fetchFromCoreData()
                completion(.success(modelToSave))
                return
            }

            let locality = networkModel.geoObject.locality.name

            if modelArray.contains(where: { $0.locality! == locality }) {
                completion(.failure(ErrorsInSaving.alreadyExist))
                return
            } else {
                let modelToSave = MainForecastsModels(context: coreDataService.managedContext)
                modelToSave.locality = locality
                modelToSave.country = networkModel.geoObject.country.name
                saveForecast(networkModel: networkModel, mainModel: modelToSave)
                coreDataService.saveContext()
                fetchFromCoreData()
                completion(.success(modelToSave))
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
        newForecastModel.moonCode = Int16(network.moonCode)
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

            hourModel.temp = Int16(hour.temp)
            hourModel.cloudness = hour.cloudness
            hourModel.feelsLike = Double(hour.feelsLike)
            hourModel.precStr = hour.precStr
            hourModel.windSpeed = hour.windSpeed * 3.6
            hourModel.windDir = hour.windDir
            hourModel.condition = convertString(string: hour.condition)
            hourModel.uvIndex = Int16(hour.uvIndex)
            hourModel.humidity = Int16(hour.humidity)

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
        newDayModel.feelsLike = Double(day.feelsLike)
        newDayModel.humidity = Int16(day.humidity)
        newDayModel.precProb = Int16(day.precProb)
        newDayModel.tempAvg = Int16(day.tempAvg)
        newDayModel.tempMax = Int16(day.tempMax)
        newDayModel.tempMin = Int16(day.tempMin)
        newDayModel.windDir = day.windDir
        newDayModel.windSpeed = day.windSpeed.rounded(.towardZero)
        newDayModel.cloudness = day.cloudness


        mainModelToSave.dayModel = newDayModel

        newNightModel.condition = convertString(string: night.condition)
        newNightModel.dayTime = night.daytime
        newNightModel.feelsLike = Double(night.feelsLike)
        newNightModel.humidity = Int16(night.humidity)
        newNightModel.precProb = Int16(night.precProb)
        newNightModel.tempAvg = Int16(night.tempAvg)
        newNightModel.tempMax = Int16(night.tempMax)
        newNightModel.tempMin = Int16(night.tempMin)
        newNightModel.windDir = night.windDir
        newNightModel.windSpeed = night.windSpeed.rounded(.towardZero)
        newNightModel.cloudness = night.cloudness

        mainModelToSave.nightModel = newNightModel

        newDayShortModel.condition = convertString(string: dayShort.condition)
        newDayShortModel.dayTime = dayShort.daytime
        newDayShortModel.feelsLike = Double(dayShort.feelsLike)
        newDayShortModel.humidity = Int16(dayShort.humidity)
        newDayShortModel.precProb = Int16(dayShort.precProb)
        newDayShortModel.temp = Int16(dayShort.temp)
        newDayShortModel.windDir = dayShort.windDir
        newDayShortModel.windSpeed = dayShort.windSpeed.rounded(.towardZero)

        mainModelToSave.dayShort = newDayShortModel

        newNightShortModel.condition = convertString(string: nightShort.condition)
        newNightShortModel.dayTime = nightShort.daytime
        newNightShortModel.feelsLike = Int16(nightShort.feelsLike)
        newNightShortModel.humidity = Int16(nightShort.humidity)
        newNightShortModel.precProb = Int16(nightShort.precProb)
        newNightShortModel.temp = Int16(nightShort.temp)
        newNightShortModel.windDir = nightShort.windDir
        newNightShortModel.windSpeed = nightShort.windSpeed.rounded(.towardZero)

        mainModelToSave.nightShort = newNightShortModel

    }
}

extension MainForecastModelService {
    private  func convertString(string: String) -> String {
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
    
    func removeAllData() {
        if let modelsArray = modelArray {
            for model in modelsArray {
                coreDataService.deleteObject(object: model)
                coreDataService.saveContext()
            }
        }
        fetchFromCoreData()
    }
}
