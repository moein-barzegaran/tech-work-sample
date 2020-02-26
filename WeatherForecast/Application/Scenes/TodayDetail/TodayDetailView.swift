//
//  TodayDetailView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/17/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class TodayDetailView: UIView {
    // MARK: - Views
    private lazy var titleLabel = Label(text: "Today's Details", font: .systemFont(ofSize: 18, weight: .bold), textColor: .current(color: .textColor))
    private lazy var sunriseIcon = Image(image: UIImage(named: "sunMove")?.imageWithColor(newColor: .orange))
    private lazy var sunriseLabel = Label(text: "-", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
    private lazy var sunsetLabel = Label(text: "-", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
    private lazy var dateStackView = HorizontalStackView()
    private lazy var pressureStackView = HorizontalStackView()
    private lazy var visibilityStackView = HorizontalStackView()
    private lazy var humidityStackView = HorizontalStackView()
    private lazy var windStackView = HorizontalStackView()
    private lazy var cloudinessStackView = HorizontalStackView()
    
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
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    func updateUI(_ currentWeatherData: CurrentWeatherModel) {
        sunriseLabel.text = currentWeatherData.sys.sunrise?.timeIntervalToHourString()
        sunsetLabel.text = currentWeatherData.sys.sunset?.timeIntervalToHourString()
        dateStackView.updateValue(value: currentWeatherData.dt.timeIntervalToDayString())
        pressureStackView.updateValue(value: "\(currentWeatherData.main.pressure ?? 0) hPa")
        visibilityStackView.updateValue(value: "\(currentWeatherData.visibility ?? 0) m")
        humidityStackView.updateValue(value: "\(currentWeatherData.main.humidity ?? 0)%")
        windStackView.updateValue(value: "\(currentWeatherData.wind.speed ?? 0) m/s, \(currentWeatherData.wind.deg ?? 0) deg")
        cloudinessStackView.updateValue(value: "\(currentWeatherData.clouds.all ?? 0)%")
    }
    
    // MARK:
    private func setupViews() {
        prepareTitleLabel()
        prepareSunriseIcon()
        prepareSunriseLabel()
        prepareSunsetLabel()
        prepareDateStackView()
        preparePressureStackView()
        prepareVisibilityStackView()
        prepareHumidityStackView()
        prepareWindStackView()
        prepareCloudinessStackView()
    }
    
    private func prepareTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
        ])
    }
    
    private func prepareSunriseIcon() {
        addSubview(sunriseIcon)
        
        NSLayoutConstraint.activate([
            sunriseIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            sunriseIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            sunriseIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            sunriseIcon.widthAnchor.constraint(equalTo: sunriseIcon.heightAnchor, multiplier: 378/200),
        ])
    }
    
    private func prepareSunriseLabel() {
        addSubview(sunriseLabel)
        
        NSLayoutConstraint.activate([
            sunriseLabel.topAnchor.constraint(equalTo: sunriseIcon.bottomAnchor, constant: 8),
            sunriseLabel.leftAnchor.constraint(equalTo: sunriseIcon.leftAnchor, constant: 5)
        ])
    }
    
    private func prepareSunsetLabel() {
        addSubview(sunsetLabel)
        
        NSLayoutConstraint.activate([
             sunsetLabel.topAnchor.constraint(equalTo: sunriseIcon.bottomAnchor, constant: 8),
             sunsetLabel.rightAnchor.constraint(equalTo: sunriseIcon.rightAnchor, constant: -5)
        ])
    }
    
    private func prepareDateStackView() {
        addSubview(dateStackView)
        
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 8),
            dateStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            dateStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            dateStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        dateStackView.icon.image = UIImage(named: "calender")?.imageWithColor(newColor: .gray)
        dateStackView.titleLabel.text = "Date"
    }
    
    private func preparePressureStackView() {
        addSubview(pressureStackView)
        
        NSLayoutConstraint.activate([
            pressureStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 0),
            pressureStackView.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            pressureStackView.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            pressureStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        pressureStackView.icon.image = UIImage(named: "gauge")?.imageWithColor(newColor: .gray)
        pressureStackView.titleLabel.text = "Pressure"
    }
    
    private func prepareVisibilityStackView() {
        addSubview(visibilityStackView)
        
        NSLayoutConstraint.activate([
            visibilityStackView.topAnchor.constraint(equalTo: pressureStackView.bottomAnchor, constant: 0),
            visibilityStackView.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            visibilityStackView.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            visibilityStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        visibilityStackView.icon.image = UIImage(named: "eye")?.imageWithColor(newColor: .gray)
        visibilityStackView.titleLabel.text = "Visibility"
    }

    private func prepareHumidityStackView() {
        addSubview(humidityStackView)

        NSLayoutConstraint.activate([
            humidityStackView.topAnchor.constraint(equalTo: visibilityStackView.bottomAnchor, constant: 0),
            humidityStackView.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            humidityStackView.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            humidityStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        humidityStackView.icon.image = UIImage(named: "humidity")?.imageWithColor(newColor: .gray)
        humidityStackView.titleLabel.text = "Humidity"
    }
    
    private func prepareWindStackView() {
        addSubview(windStackView)

        NSLayoutConstraint.activate([
            windStackView.topAnchor.constraint(equalTo: humidityStackView.bottomAnchor, constant: 0),
            windStackView.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            windStackView.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            windStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        windStackView.icon.image = UIImage(named: "wind")?.imageWithColor(newColor: .gray)
        windStackView.titleLabel.text = "Wind"
    }
    
    private func prepareCloudinessStackView() {
        addSubview(cloudinessStackView)

        NSLayoutConstraint.activate([
            cloudinessStackView.topAnchor.constraint(equalTo: windStackView.bottomAnchor, constant: 0),
            cloudinessStackView.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            cloudinessStackView.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            cloudinessStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        cloudinessStackView.icon.image = UIImage(named: "cloud")?.imageWithColor(newColor: .gray)
        cloudinessStackView.titleLabel.text = "Cloudiness"
        cloudinessStackView.dividerView.isHidden = true
    }
}

