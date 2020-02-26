//
//  Theme.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

import UIKit

enum Colors: String {
    case gradientTop
    case gradientBottom
    case background
    case divider
    case textColor

    func assetName() -> String {
        return self.rawValue
    }
}
