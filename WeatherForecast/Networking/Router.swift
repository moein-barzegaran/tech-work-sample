//
//  Router.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/12/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

enum Router {
    case getWeather(lat: Double, lon: Double)
    case hourlyWeather(lat: Double, lon: Double)
    case dailyWeather(lat: Double, lon: Double)
}

extension Router {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "worksample-api.herokuapp.com"
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .hourlyWeather:
            return "/forecast"
        case .dailyWeather:
            return "/forecast/daily"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getWeather(let lat, let lon), .hourlyWeather(let lat, let lon), .dailyWeather(let lat, let lon):
            return [URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "lon", value: "\(lon)"),
                    URLQueryItem(name: "key", value: APIKey)]
        }
    }
    
    var method: String {
        switch self {
        case .getWeather, .hourlyWeather, .dailyWeather:
            return "GET"
        }
    }
}
