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
    lazy var icon = Image(image: UIImage(named: "rain"))
    lazy var titleLabel = Label(text: "title label", textColor: .current(color: .textColor))
    lazy var valueLabel = Label(text: "-", font: .systemFont(ofSize: 16, weight: .light), textColor: .current(color: .textColor))
    lazy var dividerView = GradientView()
    
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
        prepareIconView()
        prepareTitleLabel()
        prepareValueLabel()
        prepareDivider()
    }
    
    private func prepareIconView() {
        addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: leftAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func prepareTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func prepareValueLabel() {
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.rightAnchor.constraint(equalTo: rightAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func prepareDivider() {
        addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5),
            dividerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        dividerView.firstColor = .current(color: .background)
        dividerView.secondColor = .current(color: .divider)
        dividerView.endColor = .current(color: .background)
    }
}
