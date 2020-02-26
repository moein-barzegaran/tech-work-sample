//
//  HourlyWeatherCell.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/16/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit
import SDWebImage

class HourlyWeatherCell: UICollectionViewCell {
    // MARK: Views
    private lazy var hourLabel = Label(text: "Hour", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
    private lazy var maxTempLabel = Label(text: "Max", font: .systemFont(ofSize: 16, weight: .light), textColor: .orange)
    private lazy var minTempLabel = Label(text: "Min", font: .systemFont(ofSize: 14, weight: .light), textColor: .current(color: .textColor))
    private lazy var weatherIcon = Image()
    lazy var dividerView = GradientView()
    
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
    override func prepareForReuse() {
        super.prepareForReuse()
        dividerView.isHidden = false
        weatherIcon.sd_cancelCurrentImageLoad()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dividerView.setNeedsLayout()
    }
    
    func updateUI(_ hourlyData: HourlyList) {
        hourLabel.text = hourlyData.dt?.timeIntervalToHourString()
        maxTempLabel.text = hourlyData.main?.tempMax?.toDegree
        minTempLabel.text = hourlyData.main?.tempMin?.toDegree
        if let urlString = hourlyData.weather?.first?.getWeatherIconURL(), let url = URL(string: urlString) {
            weatherIcon.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
        }
    }
    
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
        prepareHourLabel()
        prepareMaxTempLabel()
        prepareMinTempLabel()
        prepareWeatherIcon()
        prepareDividerView()
    }
    
    private func prepareHourLabel() {
        contentView.addSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func prepareMaxTempLabel() {
        contentView.addSubview(maxTempLabel)
        
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 8),
            maxTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func prepareMinTempLabel() {
        contentView.addSubview(minTempLabel)
        
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 5),
            minTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func prepareWeatherIcon() {
        contentView.addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            weatherIcon.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 5),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    private func prepareDividerView() {
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dividerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            dividerView.widthAnchor.constraint(equalToConstant: 1)
        ])
        dividerView.firstColor = .current(color: .background)
        dividerView.secondColor = .current(color: .divider)
        dividerView.endColor = .current(color: .background)
        dividerView.isHorizontal = false
    }
}
