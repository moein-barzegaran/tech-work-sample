//
//  HorizontalStackView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/18/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class HorizontalStackView: UIView {
    // MARK: - Views
    lazy var icon: Image = {
        let image = Image(image: UIImage(named: "rain"))
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: leftAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 20),
            image.widthAnchor.constraint(equalToConstant: 20)
        ])
        return image
    }()
    lazy var titleLabel: Label = {
        let label = Label(text: "title label", textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        return label
    }()
    lazy var valueLabel: Label = {
        let label = Label(text: "-", font: .systemFont(ofSize: 16, weight: .light), textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        return label
    }()
    lazy var dividerView: GradientView = {
        let gradientView = GradientView()
        addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 0.5),
            gradientView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        gradientView.firstColor = .current(color: .background)
        gradientView.secondColor = .current(color: .divider)
        gradientView.endColor = .current(color: .background)
        return gradientView
    }()
    
    // MARK: - View Initializer
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Methods
    func updateValue(value: String) {
        self.valueLabel.text = value
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
