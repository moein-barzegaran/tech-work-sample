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
    private lazy var currentLabel = Label(font: .systemFont(ofSize: 60, weight: .bold), textColor: .white)
    private lazy var cityNameLabel = Label(font: .systemFont(ofSize: 24, weight: .bold), textColor: .white)
    private lazy var weatherDescriptionLabel = Label(font: .systemFont(ofSize: 18, weight: .bold), textColor: .white)
    private lazy var weatherIcon = Image()
    private lazy var feelLikeWeather = Label(text: "Feels Like", font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
    private lazy var feelLikeWeatherLabel = Label(font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
    private lazy var minMaxWeatherLabel = Label(font: .systemFont(ofSize: 18, weight: .medium), textColor: .white)
    
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
        setupViews()
    }
    
    func updateUI(_ currentWeatherData: CurrentWeatherModel) {
        cityNameLabel.text = currentWeatherData.name
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
    
    private func setupViews() {
        prepareCurrentLabel()
        prepareDescriptionLabel()
        prepareWeatherIcon()
        prepareFeelLikeWeatherLabel()
        prepareFeelLike()
        prepareMinMaxLabel()
    }
    
    private func prepareCityNameLabel() {
        addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cityNameLabel.leftAnchor.constraint(lessThanOrEqualTo: currentLabel.rightAnchor),
            cityNameLabel.rightAnchor.constraint(equalTo: minMaxWeatherLabel.leftAnchor)
        ])
    }
    
    private func prepareCurrentLabel() {
        addSubview(currentLabel)
        
        NSLayoutConstraint.activate([
            currentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            currentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            currentLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func prepareDescriptionLabel() {
        addSubview(weatherDescriptionLabel)
        
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func prepareWeatherIcon() {
        addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
        ])
    }
    
    private func prepareFeelLikeWeatherLabel() {
        addSubview(feelLikeWeatherLabel)
        
        NSLayoutConstraint.activate([
            feelLikeWeatherLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            feelLikeWeatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
    
    private func prepareFeelLike() {
        addSubview(feelLikeWeather)
        
        NSLayoutConstraint.activate([
            feelLikeWeather.rightAnchor.constraint(equalTo: feelLikeWeatherLabel.leftAnchor, constant: -8),
            feelLikeWeather.centerYAnchor.constraint(equalTo: feelLikeWeatherLabel.centerYAnchor),
        ])
    }
    
    private func prepareMinMaxLabel() {
        addSubview(minMaxWeatherLabel)
        
        NSLayoutConstraint.activate([
            minMaxWeatherLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            minMaxWeatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        ])
    }
}
