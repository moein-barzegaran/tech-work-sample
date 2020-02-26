//
//  FavoriteCityWeatherCell.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/23/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class FavoriteCityWeatherCell: UITableViewCell {
    // MARK: - Views
    private lazy var holderView = View()
    private lazy var cityNameLabel = Label(font: .systemFont(ofSize: 20, weight: .bold))
    private lazy var minLabel = Label(font: .systemFont(ofSize: 18, weight: .regular))
    private lazy var maxLabel = Label(font: .systemFont(ofSize: 20, weight: .regular), textColor: .orange)
    private lazy var weatherIcon = Image()
    lazy var favoriteIcon = Image(image: UIImage(systemName: "star.fill")?.imageWithColor(newColor: .orange))
    
    // MARK: - View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        holderView.layer.shadowColor = UIColor.black.cgColor
        holderView.layer.shadowOpacity = 0.3
        holderView.layer.shadowOffset = CGSize.zero
        holderView.layer.shadowRadius = 5
        holderView.backgroundColor = UIColor(named: "gradientBottom")?.withAlphaComponent(0.7)
    }
    
    // MARK: - Methods
    func updateUI(_ cityData: CurrentWeatherModel) {
        cityNameLabel.text = cityData.name
        maxLabel.text = cityData.main.tempMax?.toDegree
        minLabel.text = cityData.main.tempMin?.toDegree
        if let urlString = cityData.weather.first?.getWeatherIconURL(), let url = URL(string: urlString) {
            weatherIcon.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
        }
    }
    
    private func commonInit() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        prepareHolderView()
        prepareCityNameLabel()
        prepareFavoriteIcon()
        prepareWeatherIcon()
        prepareMinLabel()
        prepareMaxLabel()
    }
    
    private func prepareHolderView() {
        contentView.addSubview(holderView)
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            holderView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            holderView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    private func prepareWeatherIcon() {
        holderView.addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            weatherIcon.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            weatherIcon.rightAnchor.constraint(equalTo: holderView.rightAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 45),
            weatherIcon.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func prepareMinLabel() {
        holderView.addSubview(minLabel)
        
        NSLayoutConstraint.activate([
            minLabel.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            minLabel.rightAnchor.constraint(equalTo: weatherIcon.leftAnchor, constant: -12),
        ])
    }
    
    private func prepareMaxLabel() {
        holderView.addSubview(maxLabel)
        
        NSLayoutConstraint.activate([
            maxLabel.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            maxLabel.rightAnchor.constraint(equalTo: minLabel.leftAnchor, constant: -12),
        ])
    }
    
    private func prepareCityNameLabel() {
        holderView.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 12),
            cityNameLabel.rightAnchor.constraint(lessThanOrEqualTo: holderView.centerXAnchor, constant: -10)
        ])
        cityNameLabel.numberOfLines = 0
    }
    
    private func prepareFavoriteIcon() {
        holderView.addSubview(favoriteIcon)
        
        favoriteIcon.isHidden = true
        NSLayoutConstraint.activate([
            favoriteIcon.centerYAnchor.constraint(equalTo: cityNameLabel.centerYAnchor),
            favoriteIcon.leftAnchor.constraint(equalTo: cityNameLabel.rightAnchor, constant: 12),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 25),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
