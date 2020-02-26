//
//  UIColor+Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/14/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func addShimmer(gradientColor: CGColor = UIColor.white.cgColor, duration: CFTimeInterval = 1.5) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 0.8
        animation.fromValue = -self.frame.width
        animation.toValue = self.frame.width
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "lskjflejf")
    }
}
