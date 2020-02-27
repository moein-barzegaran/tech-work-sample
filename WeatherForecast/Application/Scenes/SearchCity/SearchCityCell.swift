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
    lazy var titleLabel: Label = {
        let label = Label(textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
        return label
    }()
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
    }
}
