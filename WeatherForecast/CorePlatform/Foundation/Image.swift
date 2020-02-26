//
//  Image.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/26/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class Image: UIImageView {
        
    init(image: UIImage? = nil, contentMode: ContentMode? = .scaleAspectFit) {
        super.init(frame: CGRect.zero)
        self.contentMode = contentMode != nil ? contentMode! : .scaleAspectFit
        self.image = image
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

