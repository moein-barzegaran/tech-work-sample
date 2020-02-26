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
    private lazy var pressureStackView = HorizontalStackView()
    private lazy var humidityStackView = HorizontalStackView()
    private lazy var windStackView = HorizontalStackView()
    private lazy var cloudinessStackView = HorizontalStackView()
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
        preparePressureStackView()
        prepareHumidityStackView()
        prepareWindStackView()
        prepareCloudinessStackView()
    }
    
    private func preparePressureStackView() {
        addSubview(pressureStackView)
        
        NSLayoutConstraint.activate([
            pressureStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            pressureStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            pressureStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            pressureStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        pressureStackView.icon.image = UIImage(named: "gauge")?.imageWithColor(newColor: .gray)
        pressureStackView.titleLabel.text = "Pressure"
    }

    private func prepareHumidityStackView() {
        addSubview(humidityStackView)

        NSLayoutConstraint.activate([
            humidityStackView.topAnchor.constraint(equalTo: pressureStackView.bottomAnchor, constant: 0),
            humidityStackView.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            humidityStackView.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            humidityStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        humidityStackView.icon.image = UIImage(named: "humidity")?.imageWithColor(newColor: .gray)
        humidityStackView.titleLabel.text = "Humidity"
    }
    
    private func prepareWindStackView() {
        addSubview(windStackView)

        NSLayoutConstraint.activate([
            windStackView.topAnchor.constraint(equalTo: humidityStackView.bottomAnchor, constant: 0),
            windStackView.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            windStackView.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            windStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        windStackView.icon.image = UIImage(named: "wind")?.imageWithColor(newColor: .gray)
        windStackView.titleLabel.text = "Wind"
    }
    
    private func prepareCloudinessStackView() {
        addSubview(cloudinessStackView)

        NSLayoutConstraint.activate([
            cloudinessStackView.topAnchor.constraint(equalTo: windStackView.bottomAnchor, constant: 0),
            cloudinessStackView.leftAnchor.constraint(equalTo: pressureStackView.leftAnchor),
            cloudinessStackView.rightAnchor.constraint(equalTo: pressureStackView.rightAnchor),
            cloudinessStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        cloudinessStackView.icon.image = UIImage(named: "cloud")?.imageWithColor(newColor: .gray)
        cloudinessStackView.titleLabel.text = "Cloudiness"
        cloudinessStackView.dividerView.isHidden = true
    }
}
