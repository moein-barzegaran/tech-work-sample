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
    lazy var hourLabel: Label = {
        let label = Label(text: "Hour", font: .systemFont(ofSize: 12, weight: .medium), textColor: .current(color: .textColor))
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        return label
    }()
    lazy var maxTempLabel: Label = {
        let label = Label(text: "Max", font: .systemFont(ofSize: 16, weight: .light), textColor: .orange)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        return label
    }()
    lazy var minTempLabel: Label = {
        let label = Label(text: "Min", font: .systemFont(ofSize: 14, weight: .light), textColor: .current(color:
            .textColor))
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        return label
    }()
    lazy var weatherIcon: Image = {
        let image = Image()
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
        ])
        return image
    }()
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
        weatherIcon.sd_cancelCurrentImageLoad()
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        backgroundColor = .current(color: .background)
        hourLabel.font = .systemFont(ofSize: 12, weight: .medium)
        maxTempLabel.font = .systemFont(ofSize: 16, weight: .light)
        minTempLabel.font = .systemFont(ofSize: 14, weight: .light)
    }
    
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
    }
}
