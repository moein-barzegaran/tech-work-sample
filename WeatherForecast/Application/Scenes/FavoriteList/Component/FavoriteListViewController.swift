//
//  FavoriteListViewController.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/23/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    // MARK: - Views
    private lazy var addIcon = Image(image: UIImage(systemName: "plus.circle.fill")?.imageWithColor(newColor: .white))
    private lazy var closeIcon = Image(image: UIImage(systemName: "xmark.circle.fill")?.imageWithColor(newColor: .white))
    private lazy var favoriteButton = Button(titleText: "Add Your Favorite City")
    private lazy var gradientView = GradientView()
    private lazy var tableView = UITableView()
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.attributedTitle = NSAttributedString(string: "Updating...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresh
    }()
    // MARK: - Private Properties
    private var favoritesList: [FavoriteCity] = []
    private var favoriteCitiesWeatherList: [CurrentWeatherModel] = [] {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
        }
    }
    private let cellReuseIdentifier = "FavoriteCityWeatherCell"
    // MARK: - Public Properties
    var changeCityFromFavoriteList: ((Coordinate) -> ())?
    var addNewCityByCoordination: ((Coordinate) -> ())?
    lazy var viewModel: FavoriteViewModel = {
        let viewModel = FavoriteViewModel()
        viewModel.reloadData = reloadData
        return viewModel
    }()
    
    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .current(color: .gradientTop)
        setupViews()
        fetchFavoriteCities()
    }
    
    // MARK: - Methods
    private func reloadData() {
        self.tableView.endRefreshing()
        fetchFavoriteCities()
    }
    
    // Pull To Refresh
    @objc func didPullToRefresh() {
        self.refreshControl.endRefreshing()
    }
    
    // Fetch Favorite Cities From Cache Manager
    @objc private func goToSearchCityController() {
        let vc = CitySearchViewController()
        vc.addNewCityByCoordination = addNewCityToFavorite
        self.present(vc, animated: true, completion: nil)
    }
    
    // Dismiss controller
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Add New City
    func addNewCityToFavorite(_ coordinate: Coordinate) {
        self.tableView.beginRefreshing()
        self.addNewCityByCoordination?(coordinate)
        viewModel.updateWeatherByNewCoordinate(coordinate: coordinate)
    }
    
    // Fetch favorite cities from Disk and bring MyFavoriteCity to the top of the list
    private func fetchFavoriteCities() {
        if let citiesWeather = CacheManager.shared.fetchCities() {
            var list = citiesWeather
            var selectedCity = citiesWeather.first
            if let myCity = CacheManager.shared.fetchMyFavoriteCity() {
                selectedCity = myCity
            }
            if let index = citiesWeather.firstIndex(where: { $0.name == selectedCity?.name }) {
                list.remove(at: index)
                list.insert(selectedCity!, at: 0)
            }
            favoriteCitiesWeatherList = list
        }
    }
    
    private func setupViews() {
        prepareAddIcon()
        prepareFavoriteButton()
        prepareCloseIcon()
        prepareGradientView()
        prepareTableView()
    }
    
    private func prepareAddIcon() {
        view.addSubview(addIcon)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            addIcon.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 12),
            addIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addIcon.heightAnchor.constraint(equalToConstant: 20),
            addIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
        addIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSearchCityController)))
        addIcon.isUserInteractionEnabled = true
    }
    
    private func prepareFavoriteButton() {
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.leftAnchor.constraint(equalTo: addIcon.rightAnchor, constant: 8),
            favoriteButton.centerYAnchor.constraint(equalTo: addIcon.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        favoriteButton.addTarget(self, action: #selector(goToSearchCityController), for: .touchUpInside)
    }
    
    private func prepareCloseIcon() {
        view.addSubview(closeIcon)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            closeIcon.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -12),
            closeIcon.centerYAnchor.constraint(equalTo: addIcon.centerYAnchor),
            closeIcon.heightAnchor.constraint(equalToConstant: 20),
            closeIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
        closeIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        closeIcon.isUserInteractionEnabled = true
    }
    
    private func prepareGradientView() {
        view.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            gradientView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: view.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        gradientView.firstColor = .current(color: .gradientTop)
        gradientView.secondColor = .current(color: .gradientBottom)
        gradientView.endColor = .current(color: .gradientBottom)
        gradientView.isHorizontal = false
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.register(FavoriteCityWeatherCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.refreshControl = refreshControl
    }
}

// MARK: - Table view delegates
extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCitiesWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FavoriteCityWeatherCell {
            cell.favoriteIcon.isHidden = indexPath.row == 0 ? false : true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FavoriteCityWeatherCell
        cell.updateUI(favoriteCitiesWeatherList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coord = favoriteCitiesWeatherList[indexPath.row].coord
        let coordination = Coordinate(lon: coord.lon ?? 0, lat: coord.lat ?? 0)
        changeCityFromFavoriteList?(coordination)
        tableView.beginUpdates()
        let city = self.favoriteCitiesWeatherList[indexPath.row]
        self.favoriteCitiesWeatherList.remove(at: indexPath.row)
        self.favoriteCitiesWeatherList.insert(city, at: 0)
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        tableView.endUpdates()
        CacheManager.shared.saveMyFavoriteCity(city: city)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            let city = favoriteCitiesWeatherList[indexPath.row]
            favoriteCitiesWeatherList.remove(at: indexPath.row)
            CacheManager.shared.deleteCity(city: city)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
