//
//  UINavigationController+Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
    return topViewController?.preferredStatusBarStyle ?? .default
   }
}
