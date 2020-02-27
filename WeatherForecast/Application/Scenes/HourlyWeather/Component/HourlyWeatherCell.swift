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
    private lazy var hourLabel: Label = {
        let label = Label(text: "Hour", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        return label
    }()
    private lazy var maxTempLabel: Label = {
        let label = Label(text: "Max", font: .systemFont(ofSize: 16, weight: .light), textColor: .orange)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        return label
    }()
    private lazy var minTempLabel: Label = {
        let label = Label(text: "Min", font: .systemFont(ofSize: 14, weight: .light), textColor: .current(color: .textColor))
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        return label
    }()
    private lazy var weatherIcon: Image = {
        let image = Image()
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        return image
    }()
    lazy var dividerView: GradientView = {
        let gradientView = GradientView()
        contentView.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            gradientView.widthAnchor.constraint(equalToConstant: 1)
        ])
        gradientView.firstColor = .current(color: .background)
        gradientView.secondColor = .current(color: .divider)
        gradientView.endColor = .current(color: .background)
        gradientView.isHorizontal = false
        return gradientView
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
    }
}
