//
//  ForecastDailyModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/15/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//
import Foundation

// MARK: - ForecastDailyModel
struct ForecastDailyModel: Codable {
    let city: DailyCity?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [DailyList]?
}

// MARK: - City
struct DailyCity: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone: Int?
}

// MARK: - List
struct DailyList: Codable {
    let dt, sunrise, sunset: Double?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let weather: [Weather]?
    let speed: Double?
    let deg, clouds: Int?
    let rain: Double?
    let snow: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike
        case pressure, humidity, weather, speed, deg, clouds, rain, snow
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night, eve, morn: Double?
}
