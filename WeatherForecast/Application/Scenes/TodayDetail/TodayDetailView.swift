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
    private lazy var titleLabel: Label = {
        let label = Label(text: "Today's Details", font: .systemFont(ofSize: 18, weight: .bold), textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
        ])
        return label
    }()
    private lazy var sunriseIcon: Image = {
        let image = Image(image: UIImage(named: "sunMove")?.imageWithColor(newColor: .orange))
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 378/200),
        ])
        return image
    }()
    private lazy var sunriseLabel: Label = {
        let label = Label(text: "-", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: sunriseIcon.bottomAnchor, constant: 8),
            label.leftAnchor.constraint(equalTo: sunriseIcon.leftAnchor, constant: 5)
        ])
        return label
    }()
    private lazy var sunsetLabel: Label = {
        let label = Label(text: "-", font: .systemFont(ofSize: 16, weight: .medium), textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
             label.topAnchor.constraint(equalTo: sunriseIcon.bottomAnchor, constant: 8),
             label.rightAnchor.constraint(equalTo: sunriseIcon.rightAnchor, constant: -5)
        ])
        return label
    }()
    private lazy var dateStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 8),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "calender")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Date"
        return stack
    }()
    private lazy var pressureStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "gauge")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Pressure"
        return stack
    }()
    private lazy var visibilityStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: pressureStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "eye")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Visibility"
        return stack
    }()
    private lazy var humidityStackView: HorizontalStackView = {
        let stack = HorizontalStackView()
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: visibilityStackView.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
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
            stack.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
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
            stack.leftAnchor.constraint(equalTo: dateStackView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: dateStackView.rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
        stack.icon.image = UIImage(named: "cloud")?.imageWithColor(newColor: .gray)
        stack.titleLabel.text = "Cloudiness"
        stack.dividerView.isHidden = true
        return stack
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
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    func updateUI(_ currentWeatherData: CurrentWeatherModel) {
        sunriseLabel.text = currentWeatherData.sys.sunrise?.timeIntervalToHourString()
        sunsetLabel.text = currentWeatherData.sys.sunset?.timeIntervalToHourString()
        dateStackView.updateValue(value: currentWeatherData.dt.timeIntervalToDayStringWithoutToday())
        pressureStackView.updateValue(value: "\(currentWeatherData.main.pressure ?? 0) hPa")
        visibilityStackView.updateValue(value: "\(currentWeatherData.visibility ?? 0) m")
        humidityStackView.updateValue(value: "\(currentWeatherData.main.humidity ?? 0)%")
        windStackView.updateValue(value: "\(currentWeatherData.wind.speed ?? 0) m/s, \(currentWeatherData.wind.deg ?? 0) deg")
        cloudinessStackView.updateValue(value: "\(currentWeatherData.clouds.all ?? 0)%")
    }
}

