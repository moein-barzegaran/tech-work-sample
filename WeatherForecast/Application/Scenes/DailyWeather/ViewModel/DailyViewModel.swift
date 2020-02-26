//
//  DailyViewModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

class DailyViewModel: NSObject {
    // MARK: Public Vars
    var dailyList: [DailyList] = []
    
    init(dailyWeatherData: ForecastDailyModel) {
        if let list = dailyWeatherData.list {
            self.dailyList = list
        }
        super.init()
    }
}
