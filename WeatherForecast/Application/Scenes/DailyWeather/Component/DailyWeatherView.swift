//
//  DailyWeatherView.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/17/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class DailyWeatherView: UIView {
    // MARK: - Views
    private lazy var titleLabel: Label = {
        let label = Label(text: "Daily Forecast", font: .systemFont(ofSize: 18, weight: .bold), textColor: .current(color: .textColor))
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
            collection.heightAnchor.constraint(equalToConstant: 150)
        ])
        collection.collectionViewLayout = self.collectionViewFlowLayout
        collection.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collection.showsHorizontalScrollIndicator = false
        collection.register(DailyWeatherCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collection.backgroundColor = .current(color: .background)
        return collection
    }()
    private lazy var dailyWeatherDetailView: DailyWeatherDetailView = {
        let detailView = DailyWeatherDetailView()
        addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            detailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            detailView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        return detailView
    }()
    private lazy var collectionViewFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        return layout
    }()
    // MARK: - Private Properties
    private let cellReuseIdentifier = "DailyCell"
    // MARK: - Public Properties
    var dailyDetailChanged: ((Bool) -> ())?
    var selectedCellIndexPath: IndexPath?
    var dailyViewModel: DailyViewModel!
    
    // MARK: - View Initializers
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
    
    func configuration(_ data: ForecastDailyModel) {
        dailyViewModel = DailyViewModel(dailyWeatherData: data)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
    }
}

extension DailyWeatherView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyViewModel.dailyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! DailyWeatherCell
        cell.updateUI(dailyViewModel.dailyList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DailyWeatherCell {
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowOffset = CGSize.zero
            cell.layer.shadowRadius = 5
            cell.backgroundColor = .current(color: .background)
            cell.hourLabel.font = .systemFont(ofSize: 12, weight: .bold)
            cell.maxTempLabel.font = .systemFont(ofSize: 16, weight: .medium)
            cell.minTempLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            if let selectedIndex = selectedCellIndexPath {
                collectionView.reloadItems(at: [selectedIndex])
            }
            
            if selectedCellIndexPath == indexPath {
                dailyDetailChanged?(false)
                selectedCellIndexPath = nil
            } else {
                dailyDetailChanged?(true)
                if !dailyViewModel.dailyList.isEmpty {
                    self.dailyWeatherDetailView.dailyWeatherData = dailyViewModel.dailyList[indexPath.row]
                }
                selectedCellIndexPath = indexPath
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: collectionView.frame.height * 0.75)
    }
}
