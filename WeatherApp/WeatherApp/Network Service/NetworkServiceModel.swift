//
//  NetworkServiceModel.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import Foundation

final class NetworkServiceModel: Codable {
     let serverTime: String
     let forecast: [ForecastNetworkModel]
    let geoObject: GeoObject

    private enum CodingKeys: String, CodingKey {
        case serverTime = "now_dt"
        case geoObject = "geo_object"
        case forecast = "forecasts"
    }

    init(serverTime: String, geoObject: GeoObject, forecast: [ForecastNetworkModel]) {
        self.serverTime = serverTime
        self.geoObject = geoObject
        self.forecast = forecast
    }
}

final class GeoObject: Codable {
    let locality: Locality
    let country: Country

    private enum CodingKeys: String, CodingKey {
        case locality = "locality"
        case country = "country"
    }

    init(locality: Locality, country:  Country) {
        self.locality = locality
        self.country = country
    }
}

final class Locality: Codable {
    let name: String

    private enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    init(name: String) {
        self.name = name
    }
}

final class Country: Codable {

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
    let moonText: String
    let partObj: Parts
    let hours: [HoursNetworkModel]

    private enum CodingKeys: String, CodingKey {
        case moonText = "moon_text"
        case partObj = "parts"
        case date = "date"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case hours = "hours"
    }

    init(date: String, sunrise: String, sunset: String, moonText: String,partObj: Parts, hours: [HoursNetworkModel]) {
        self.date = date
        self.sunrise = sunrise
        self.sunset = sunset
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
    let cloudness: Double

    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case precProb = "prec_prob"
        case condition = "condition"
        case daytime = "daytime"
        case humidity = "humidity"
        case tempAvg = "temp_avg"
        case cloudness = "cloudness"
    }

    init(tempMin: Int, tempMax: Int, feelsLike: Int, condition: String, daytime: String, windSpeed: Double, windDir: String, humidity: Int, precProb: Int, tempAvg: Int, cloudness: Double) {
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
        self.cloudness = cloudness
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
        case windSpeed = "wind_speed"
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

    private enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
    }

    init(day: PartInfoNetworkModel, night: PartInfoNetworkModel) {
        self.day = day
        self.night = night
    }
}


