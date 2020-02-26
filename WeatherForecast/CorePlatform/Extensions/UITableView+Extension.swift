//
//  UITableView+Extension.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/25/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

extension UITableView {
    func beginRefreshing() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
