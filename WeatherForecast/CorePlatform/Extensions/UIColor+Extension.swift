//
//  UIColor+Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import SwiftUI

extension UIColor {
    // Return color by the name
    static func current(color: Colors) -> UIColor {
        return UIColor(named: color.assetName())!
    }
}
