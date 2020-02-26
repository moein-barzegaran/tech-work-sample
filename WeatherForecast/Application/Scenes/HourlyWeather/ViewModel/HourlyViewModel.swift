//
//  HourlyViewModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

class HourlyViewModel: NSObject {
    // MARK: Public Vars
    var hourlyList: [HourlyList] = []
    
    init(hourlyWeatherData: ForecastHourlyModel) {
        if let list = hourlyWeatherData.list {
            self.hourlyList = list
        }
        super.init()
    }
}
