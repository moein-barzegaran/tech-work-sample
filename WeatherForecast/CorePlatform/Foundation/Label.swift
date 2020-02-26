//
//  Label.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/26/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    init(text: String? = "", font: UIFont? = .systemFont(ofSize: 16, weight: .regular), textColor: UIColor? = .white) {
        super.init(frame: CGRect.zero)
        self.font = font
        self.textColor = textColor
        self.text = text
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
