//
//  DailyWeatherCell.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/17/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {
    // MARK: - Views
    lazy var hourLabel = Label(text: "Hour", font: .systemFont(ofSize: 12, weight: .medium), textColor: .current(color: .textColor))
    lazy var maxTempLabel = Label(text: "Max", font: .systemFont(ofSize: 16, weight: .light), textColor: .orange)
    lazy var minTempLabel = Label(text: "Min", font: .systemFont(ofSize: 14, weight: .light), textColor: .current(color: .textColor))
    lazy var weatherIcon = Image()
    
    // MARK: - View Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherIcon.sd_cancelCurrentImageLoad()
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        backgroundColor = .current(color: .background)
        hourLabel.font = .systemFont(ofSize: 12, weight: .medium)
        maxTempLabel.font = .systemFont(ofSize: 16, weight: .light)
        minTempLabel.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    // MARK: - Methods
    func updateUI(_ dailyData: DailyList) {
        hourLabel.text = dailyData.dt?.timeIntervalToDayString()
        maxTempLabel.text = dailyData.temp?.max?.toDegree
        minTempLabel.text = dailyData.temp?.min?.toDegree
        if let urlString = dailyData.weather?.first?.getWeatherIconURL(), let url = URL(string: urlString) {
            weatherIcon.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
        }
    }
    
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
        prepareWeatherIcon()
        prepareHourLabel()
        prepareMaxTempLabel()
        prepareMinTempLabel()
    }
    
    private func prepareWeatherIcon() {
        contentView.addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
        ])
    }
    
    private func prepareHourLabel() {
        contentView.addSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func prepareMaxTempLabel() {
        contentView.addSubview(maxTempLabel)
        
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
            maxTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func prepareMinTempLabel() {
        contentView.addSubview(minTempLabel)
        
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 5),
            minTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
