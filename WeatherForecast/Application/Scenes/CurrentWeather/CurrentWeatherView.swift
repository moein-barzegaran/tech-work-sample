//
//  CurrentWeatherView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/16/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    // MARK: - Views
    private lazy var currentLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 60, weight: .bold), textColor: .white)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            label.widthAnchor.constraint(equalToConstant: 150)
        ])
        return label
    }()
    private lazy var weatherDescriptionLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 18, weight: .bold), textColor: .white)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            label.rightAnchor.constraint(equalTo: feelLikeWeather.leftAnchor, constant: -8)
        ])
        return label
    }()
    private lazy var weatherIcon: Image = {
        let image = Image()
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
        ])
        return image
    }()
    private lazy var feelLikeWeather: Label = {
        let label = Label(text: "Feels Like", font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
        addSubview(label)

        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: feelLikeWeatherLabel.leftAnchor, constant: -8),
            label.centerYAnchor.constraint(equalTo: feelLikeWeatherLabel.centerYAnchor),
        ])
        return label
    }()
    private lazy var feelLikeWeatherLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
        return label
    }()
    private lazy var minMaxWeatherLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        ])
        return label
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
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    func updateUI(_ currentWeatherData: CurrentWeatherModel) {
        currentLabel.text = currentWeatherData.main.temp?.toDegree
        weatherDescriptionLabel.text = currentWeatherData.weather.first?.weatherDescription
        feelLikeWeatherLabel.text = currentWeatherData.main.feelsLike?.toDegree
        if let minTemp = currentWeatherData.main.tempMin?.toDegree, let maxTemp = currentWeatherData.main.tempMax?.toDegree {
            minMaxWeatherLabel.attributedText = makeColorLabel(max: maxTemp, min: minTemp)
        }
        if let urlString = currentWeatherData.weather.first?.getWeatherIconURL(), let url = URL(string: urlString) {
            weatherIcon.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
        }
    }
    
    private func makeColorLabel(max: String, min: String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : UIColor.orange]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attributedString1 = NSMutableAttributedString(string: max, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string: min, attributes:attrs2)

        attributedString1.append(NSAttributedString(string: " "))
        attributedString1.append(attributedString2)
        return  attributedString1
    }
}
