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
    private lazy var titleLabel = Label(text: "Daily Forecast", font: .systemFont(ofSize: 18, weight: .bold), textColor: .current(color: .textColor))
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .current(color: .background)
        return collection
    }()
    private lazy var dailyWeatherDetailView = DailyWeatherDetailView()
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
        if !subviews.contains(where: {$0 is UICollectionView}) {
            prepareCollectionView()
            prepareDailyWeatherDetailView()
        }
    }
    
    func configuration(_ data: ForecastDailyModel) {
        dailyViewModel = DailyViewModel(dailyWeatherData: data)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    private func commonInit() {
        self.backgroundColor = .current(color: .background)
        setupViews()
    }
    
    private func setupViews() {
        prepareTitleLabel()
    }
    
    private func prepareTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
        ])
    }
    
    private func prepareCollectionView() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        self.collectionView.backgroundColor = .current(color: .background)
    }
    
    private func prepareDailyWeatherDetailView() {
        addSubview(dailyWeatherDetailView)
        
        NSLayoutConstraint.activate([
            dailyWeatherDetailView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            dailyWeatherDetailView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            dailyWeatherDetailView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            dailyWeatherDetailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
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
