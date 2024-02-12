//
//  NetworkServiceModel.swift
//  WeatherApp
//
//  Created by Максим Жуин on 12.02.2024.
//

import Foundation

final class NetworkServiceModel: Codable {
    private let serverTime: String
    private let info: InfoNetworkModel
    private let fact: FactNetworkModel
    private let forecast: [ForecastNetworkModel]

    private enum CodingKeys: String, CodingKey {
        case serverTime = "now_dt"
        case info = "info"
        case fact = "fact"
        case forecast = "forecasts"
    }

    init(serverTime: String, info: InfoNetworkModel, fact: FactNetworkModel, forecast: [ForecastNetworkModel]) {
        self.serverTime = serverTime
        self.info = info
        self.fact = fact
        self.forecast = forecast
    }
}


final class InfoNetworkModel: Codable {
    private let lat: Double
    private let lon: Double

    init(lat: Double, lon:  Double) {
        self.lat = lat
        self.lon = lon
    }
}

final class FactNetworkModel: Codable {

    private let temp: Int
    private let feelsLike: Int
    private let condition: String
    private let windSpeed: Double
    private let windDir: String
    private let humidity: Int
    private let daytime: String

    private enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case temp = "temp"
        case humidity = "humidity"
        case daytime = "daytime"
        case condition = "condition"
    }

    init(temp: Int, feelsLike: Int, condition: String, windSpeed: Double, windDir: String, humidity: Int, daytime: String) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.condition = condition
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.daytime = daytime
    }
}

final class ForecastNetworkModel: Codable {
    private let date: String
    private let week: Int
    private let sunrise: String
    private let sunset: String
    private let moonCode: Int
    private let moonText: String
    private let partObj: [PartNetworkModel]

    private enum CodingKeys: String, CodingKey {
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case partObj = "parts"
        case date = "date"
        case week = "week"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }

    init(date: String, week: Int, sunrise: String, sunset: String, moonCode: Int, moonText: String, partObj: [PartNetworkModel]) {
        self.date = date
        self.week = week
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonCode = moonCode
        self.moonText = moonText
        self.partObj = partObj
    }
}

final class PartNetworkModel: Codable {

    private let name: String
    private let tempMin: Int
    private let tempMax: Int
    private let feelsLike: String
    private let condition: String
    private let daytime: String
    private let windSpeed: Double
    private let windDir: String
    private let humidity: Int
    private let precProb: Int

    private enum CodingKeys: String, CodingKey {
        case name = "part_name"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case precProb = "prec_prob"
        case condition = "condition"
        case daytime = "daytime"
        case humidity = "humidity"
    }

    init(name: String, tempMin: Int, tempMax: Int, feelsLike: String, condition: String, daytime: String, windSpeed: Double, windDir: String, humidity: Int, precProb: Int) {
        self.name = name
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.feelsLike = feelsLike
        self.condition = condition
        self.daytime = daytime
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.precProb = precProb
    }

}
