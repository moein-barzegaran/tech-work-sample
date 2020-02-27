//
//  Double_Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/15/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

extension Double {
    var toDegree: String {
        return String(format: "%0.f", self) + "°"
    }
    
    func timeIntervalToDayString() -> String {
        let calender = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: self) ?? TimeInterval.init())
        let df = DateFormatter()
        df.dateFormat = "EEE dd"
        return calender.isDateInToday(date) ? "Today" : df.string(from: date)
    }
    
    func timeIntervalToDayStringWithoutToday() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: self) ?? TimeInterval.init())
        let df = DateFormatter()
        df.dateFormat = "EEE dd"
        return df.string(from: date)
    }
    
    func timeIntervalToHourString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: self) ?? TimeInterval.init())
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df.string(from: date)
    }
}
