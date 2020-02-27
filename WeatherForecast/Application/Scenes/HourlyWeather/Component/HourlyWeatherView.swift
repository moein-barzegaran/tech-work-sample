//
//  HourlyWeatherView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/16/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class HourlyWeatherView: UIView {
    // MARK: - Views
    private lazy var titleLabel: Label = {
        let label = Label(text: "Hourly Forecast", font: .systemFont(ofSize: 18, weight: .bold), textColor: .current(color: .textColor))
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
        ])
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collection.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            collection.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .current(color: .background)
        collection.collectionViewLayout = collectionViewFlowLayout
        collection.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        return collection
    }()
    private lazy var collectionViewFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.height : UIScreen.main.bounds.width) * 0.25, height: 180)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    // MARK: - Private Properties
    private let cellReuseIdentifier = "HourlyCell"
    private var hourlyViewModel: HourlyViewModel!
    
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
    
    func configuration(_ data: ForecastHourlyModel) {
        hourlyViewModel = HourlyViewModel(hourlyWeatherData: data)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
    }
}

extension HourlyWeatherView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyViewModel.hourlyList.count > 0 ? 16 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! HourlyWeatherCell
        cell.updateUI(hourlyViewModel.hourlyList[indexPath.row])
        if indexPath.row == 15 {
            cell.dividerView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width > 500 ? UIScreen.main.bounds.height : UIScreen.main.bounds.width) * 0.25, height: collectionView.frame.height * 0.9)
    }
}
