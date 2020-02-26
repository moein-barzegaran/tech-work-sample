//
//  ForecastHourlyModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/15/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

// MARK: - ForecastHourlyModel
struct ForecastHourlyModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [HourlyList]?
    let city: HourlyCity?
}

// MARK: - City
struct HourlyCity: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - List
struct HourlyList: Codable {
    let dt: Double?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
