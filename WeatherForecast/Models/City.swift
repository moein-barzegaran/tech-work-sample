//
//  City.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/22/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

struct City: Codable {
    var id: Double
    var name: String
    var country: String
    var coord: Coordinate
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}
