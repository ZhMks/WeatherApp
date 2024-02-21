//
//  NetworkServiceModel.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import Foundation

final class NetworkServiceModel: Codable {
     let serverTime: String
     let info: InfoNetworkModel
     let forecast: [ForecastNetworkModel]

    private enum CodingKeys: String, CodingKey {
        case serverTime = "now_dt"
        case info = "info"
        case forecast = "forecasts"
    }

    init(serverTime: String, info: InfoNetworkModel, forecast: [ForecastNetworkModel]) {
        self.serverTime = serverTime
        self.info = info
        self.forecast = forecast
    }
}


final class InfoNetworkModel: Codable {
    let lat: Double
    let lon: Double
    let tzInfo: TzInfo

    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case tzInfo = "tzinfo"
    }

    init(lat: Double, lon:  Double, tzInfo: TzInfo) {
        self.lat = lat
        self.lon = lon
        self.tzInfo = tzInfo
    }
}

final class TzInfo: Codable {
    let name: String

    private enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    init(name: String) {
        self.name = name
    }
}

final class ForecastNetworkModel: Codable {

    let date: String
    let sunrise: String
    let sunset: String
    let moonCode: Int
    let moonText: String
    let partObj: Parts
    let hours: [HoursNetworkModel]

    private enum CodingKeys: String, CodingKey {

        case moonCode = "moon_code"
        case moonText = "moon_text"
        case partObj = "parts"
        case date = "date"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case hours = "hours"
    }

    init(date: String, sunrise: String, sunset: String, moonCode: Int, moonText: String,partObj: Parts, hours: [HoursNetworkModel]) {
        self.date = date
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonCode = moonCode
        self.moonText = moonText
        self.partObj = partObj
        self.hours = hours
    }
}

final class PartInfoNetworkModel: Codable {

    let tempMin: Int
    let tempMax: Int
    let feelsLike: Int
    let condition: String
    let daytime: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let precProb: Int
    let tempAvg: Int

    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case windSpeed = "wind_gust"
        case windDir = "wind_dir"
        case precProb = "prec_prob"
        case condition = "condition"
        case daytime = "daytime"
        case humidity = "humidity"
        case tempAvg = "temp_avg"
    }

    init(tempMin: Int, tempMax: Int, feelsLike: Int, condition: String, daytime: String, windSpeed: Double, windDir: String, humidity: Int, precProb: Int, tempAvg: Int) {
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.feelsLike = feelsLike
        self.condition = condition
        self.daytime = daytime
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.precProb = precProb
        self.tempAvg = tempAvg
    }
}

final class HoursNetworkModel: Codable {

    let hour: Double
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let precStr: Double
    let cloudness: Double
    let uvIndex: Int

    private enum CodingKeys: String, CodingKey {
        case hour = "hour_ts"
        case temp = "temp"
        case condition = "condition"
        case feelsLike = "feels_like"
        case windSpeed = "wind_gust"
        case windDir = "wind_dir"
        case humidity = "humidity"
        case precStr = "prec_strength"
        case cloudness = "cloudness"
        case uvIndex = "uv_index"
    }

    init(hour: Double, temp: Int, feelsLike: Int, condition: String, windSpeed: Double, windDir: String, humidity: Int, precStr: Double, cloudness: Double, uvIndex: Int) {
        self.hour = hour
        self.temp = temp
        self.feelsLike = feelsLike
        self.condition = condition
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.precStr = precStr
        self.cloudness = cloudness
        self.uvIndex = uvIndex
    }

}

final class Parts: Codable {
    let day: PartInfoNetworkModel
    let night: PartInfoNetworkModel
    let dayShort: ShortNetworkModel
    let nightShort: ShortNetworkModel

    private enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case dayShort = "day_short"
        case nightShort = "night_short"
    }

    init(day: PartInfoNetworkModel, night: PartInfoNetworkModel, dayShort: ShortNetworkModel, nightShort: ShortNetworkModel) {
        self.day = day
        self.night = night
        self.dayShort = dayShort
        self.nightShort = nightShort
    }
}

final class ShortNetworkModel: Codable {

    let temp: Int
    let feelsLike: Int
    let condition: String
    let daytime: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let precProb: Int

    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case precProb = "prec_prob"
        case condition = "condition"
        case daytime = "daytime"
        case humidity = "humidity"
    }

    init(temp: Int, feelsLike: Int, condition: String, daytime: String, windSpeed: Double, windDir: String, humidity: Int, precProb: Int) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.condition = condition
        self.daytime = daytime
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.precProb = precProb
    }
}

