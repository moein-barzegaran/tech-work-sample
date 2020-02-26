//
//  Weather+Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/16/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

extension Weather {
    func getWeatherIconURL() -> String {
        if let iconID = self.icon {
            return Constant.weatherIconBaseURL + iconID + "@2x.png"
        }
        return ""
    }
}
