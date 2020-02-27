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
    private lazy var holderView: View = {
        let view = View()
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        return view
    }()
    private lazy var cityNameLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 20, weight: .bold))
         holderView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            label.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 12),
            label.rightAnchor.constraint(lessThanOrEqualTo: holderView.centerXAnchor, constant: -10)
        ])
        label.numberOfLines = 0
        return label
    }()
    private lazy var minLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 18, weight: .regular))
        holderView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            label.rightAnchor.constraint(equalTo: weatherIcon.leftAnchor, constant: -12),
        ])
        return label
    }()
    private lazy var maxLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 20, weight: .regular), textColor: .orange)
       holderView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            label.rightAnchor.constraint(equalTo: minLabel.leftAnchor, constant: -12),
        ])
        return label
    }()
    private lazy var weatherIcon: Image = {
        let image = Image()
       holderView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            image.rightAnchor.constraint(equalTo: holderView.rightAnchor),
            image.heightAnchor.constraint(equalToConstant: 45),
            image.widthAnchor.constraint(equalToConstant: 45)
        ])
        return image
    }()
    lazy var favoriteIcon: Image = {
        let image = Image(image: UIImage(systemName: "star.fill")?.imageWithColor(newColor: .orange))
        holderView.addSubview(image)
        
        image.isHidden = true
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: cityNameLabel.centerYAnchor),
            image.leftAnchor.constraint(equalTo: cityNameLabel.rightAnchor, constant: 12),
            image.widthAnchor.constraint(equalToConstant: 25),
            image.heightAnchor.constraint(equalToConstant: 25)
        ])
        return image
    }()
    
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
    }
}
