//
//  DailyWeatherDetailView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/19/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class DailyWeatherDetailView: UIView {
    // MARK: - Views
    private lazy var pressureStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "gauge")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Pressure"
        return stack
    }()
    private lazy var humidityStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: pressureStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "humidity")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Humidity"
        return stack
    }()
    private lazy var windStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: humidityStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "wind")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Wind"
        return stack
    }()
    private lazy var cloudinessStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: windStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "cloud")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Cloudiness"
        stack.dividerView.isHidden = true
        return stack
    }()
    // MARK: - Publlic Properties
    var dailyWeatherData: DailyList! {
        didSet {
            updateUI()
        }
    }
    // MARK: - View Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    // MARK: - Methods
    private func updateUI() {
        pressureStackView.updateValue(value: "\(dailyWeatherData.pressure ?? 0)hPa")
        humidityStackView.updateValue(value: "\(dailyWeatherData.humidity ?? 0)%")
        windStackView.updateValue(value: "\(dailyWeatherData.speed ?? 0)m/s, \(dailyWeatherData.deg ?? 0)deg")
        cloudinessStackView.updateValue(value: "\(dailyWeatherData.clouds ?? 0)%")
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
