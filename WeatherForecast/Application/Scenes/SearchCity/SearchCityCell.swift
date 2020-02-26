//
//  SearchCityCell.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/21/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {
    // MARK: - Views
    lazy var titleLabel = Label(textColor: .current(color: .textColor))
    // MARK: - View Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .current(color: .background)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
}
