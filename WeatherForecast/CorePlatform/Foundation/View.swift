//
//  View.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/26/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class View: UIView {

    init(backgroundColor: UIColor? = .clear) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = backgroundColor
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
