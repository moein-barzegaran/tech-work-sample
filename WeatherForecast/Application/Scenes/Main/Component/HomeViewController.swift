//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/23/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    // MARK: - Views
    // MARK: Scroll view
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(scroll)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: margins.topAnchor),
            scroll.leftAnchor.constraint(equalTo: view.leftAnchor),
            scroll.rightAnchor.constraint(equalTo: view.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        scroll.addSubview(refreshControl)
        return scroll
    }()
    // MARK: Holder view
    private lazy var holderView: GradientView = {
        let gradientView = GradientView()
        view.addSubview(gradientView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: margins.topAnchor),
            gradientView.widthAnchor.constraint(equalTo: view.widthAnchor),
            gradientView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        gradientView.firstColor = .current(color: .gradientTop)
        gradientView.secondColor = .current(color: .gradientBottom)
        gradientView.endColor = .current(color: .gradientBottom)
        gradientView.isHorizontal = false
        return gradientView
    }()
    // MARK: Current weather view
    private lazy var currentWeatherView: CurrentWeatherView = {
        let currentView = CurrentWeatherView()
        currentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(currentView)
        
        NSLayoutConstraint.activate([
            currentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            currentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentView.heightAnchor.constraint(equalToConstant: 150)
        ])
        return currentView
    }()
    // MARK: Hourly weather view
    private lazy var hourlyWeatherView: HourlyWeatherView = {
        let hourlyView = HourlyWeatherView()
        hourlyView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hourlyView)
        
        NSLayoutConstraint.activate([
            hourlyView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 15),
            hourlyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            hourlyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourlyView.heightAnchor.constraint(equalToConstant: 200)
        ])
        return hourlyView
    }()
    // MARK: Today detail view
    private lazy var todayDetailView: TodayDetailView = {
        let todayView = TodayDetailView()
        scrollView.addSubview(todayView)
        todayView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: dailyWeatherView.bottomAnchor, constant: 15),
            todayView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            todayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayView.heightAnchor.constraint(equalToConstant: 410),
            todayView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
        return todayView
    }()
    // MARK: Daily weather view
    private lazy var dailyWeatherView: DailyWeatherView = {
        let dailyView = DailyWeatherView()
        dailyView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(dailyView)
        
        NSLayoutConstraint.activate([
            dailyView.topAnchor.constraint(equalTo: hourlyWeatherView.bottomAnchor, constant: 15),
            dailyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            dailyView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        heightOfDailyView = dailyView.heightAnchor.constraint(equalToConstant: 200)
        heightOfDailyView.isActive = true
        dailyView.dailyDetailChanged = dailyDetailView
        return dailyView
    }()
    // MARK: Refresh Control
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.attributedTitle = NSAttributedString(string: "Updating...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return refresh
    }()
    // MARK: Lottie View
    private lazy var lottieView: AnimationView = {
        let lottie = AnimationView(name: "lottieLoading")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(lottie)
        
        NSLayoutConstraint.activate([
            lottie.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottie.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: view.frame.width > 500 ? 0.3 : 0.75),
            lottie.heightAnchor.constraint(equalTo: lottie.widthAnchor)
        ])
        lottie.contentMode = .scaleAspectFit
        lottie.loopMode = .loop
        return lottie
    }()
    // MARK: - Private Properties
    private var widthOfLottieView: NSLayoutConstraint!
    private var heightOfDailyView: NSLayoutConstraint!
    // MARK: - Public Properties
    lazy var viewModel: HomeListViewModel = {
        let viewModel = HomeListViewModel()
        viewModel.reloadCurrentWeatherView = currentWeatherView.updateUI
        viewModel.reloadHourlyWeatherView = hourlyWeatherView.configuration
        viewModel.reloadDailyWeatherView = dailyWeatherView.configuration
        viewModel.reloadTodayWeatherView = todayDetailView.updateUI
        viewModel.showLocationAlertView = showLocationDisableAlertView
        viewModel.navigationBarTitleChanged = navigationTitleChanged
        viewModel.locationPermissionReady = locationPermissionReady
        viewModel.locationNotAvailable = locationNotAvailable
        return viewModel
    }()
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        scrollView.isHidden = true
        lottieView.play()
        viewModel.getLocationWithPermission()
        view.backgroundColor = .current(color: .gradientTop)
    }
    // MARK: - Methods
    // Change Status bar to light style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Change Coordination of current location
    func changeCoordinationAndUpdate(_ coordinate: Coordinate) {
        viewModel.updateWeatherByNewCoordinate(coordinate: coordinate)
    }
    
    // Go to search viewController
    func changeCoordinationAndUpdate() {
        searchTapped()
    }
    
    // Changing navigation title by new one
    func navigationTitleChanged(_ title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    // Current Location fetched
    func locationPermissionReady() {
        viewModel.pullToRefresh {
            self.lottieView.stop()
            self.scrollView.isHidden = false
            self.holderView.bringSubviewToFront(self.scrollView)
        }
    }
    
    // Current location not available
    func locationNotAvailable() {
        let alert = UIAlertController(title: "Location Service is unavailable", message: "Please make sure your device location is enable", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // daily detail view
    func dailyDetailView(_ show: Bool) {
        let animator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 0.7) {
            self.heightOfDailyView.constant = show ? 400 : 200
            self.dailyWeatherView.superview?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    // Location Alert
    func showLocationDisableAlertView() {
        let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Search button tapped
    @objc func searchTapped() {
        let vc = CitySearchViewController()
        vc.addNewCityByCoordination = changeCoordinationAndUpdate
        self.present(vc, animated: true, completion: nil)
    }
    
    // Navigation button tapped
    @objc func favoriteTapped() {
        let vc = FavoriteListViewController()
        vc.changeCityFromFavoriteList = changeCoordinationAndUpdate
        vc.addNewCityByCoordination = changeCoordinationAndUpdate
        self.present(vc, animated: true, completion: nil)
    }
    
    // Pull To Refresh
    @objc func didPullToRefresh() {
        viewModel.pullToRefresh() {
            self.refreshControl.endRefreshing()
        }
    }
    
    // Prepare navigation bar
    private func setupNavigationBar() {
        // Make transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        let favorite = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(favoriteTapped))

        navigationItem.rightBarButtonItems = [search]
        navigationItem.leftBarButtonItems = [favorite]
    }
}
