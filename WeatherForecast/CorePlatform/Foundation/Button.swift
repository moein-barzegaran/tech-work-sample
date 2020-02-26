//
//  Button.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/26/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class Button: UIButton {

    init(titleText: String? = "") {
        super.init(frame: CGRect.zero)
        self.setTitle(titleText, for: .normal)
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
