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
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var holderView = GradientView()
    private lazy var currentWeatherView = CurrentWeatherView()
    private lazy var hourlyWeatherView = HourlyWeatherView()
    private lazy var todayDetailView = TodayDetailView()
    private lazy var dailyWeatherView: DailyWeatherView = {
        let view = DailyWeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dailyDetailChanged = dailyDetailView
        return view
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.attributedTitle = NSAttributedString(string: "Updating...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return refresh
    }()
    private lazy var lottieView: AnimationView = {
        let view = AnimationView(name: "lottieLoading")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    // MARK: - Public Properties
    weak var heightOfDailyView: NSLayoutConstraint!
    lazy var viewModel: HomeListViewModel = {
        let viewModel = HomeListViewModel()
        viewModel.reloadCurrentWeatherView = currentWeatherView.updateUI
        viewModel.reloadHourlyWeatherView = hourlyWeatherView.configuration
        viewModel.reloadDailyWeatherView = dailyWeatherView.configuration
        viewModel.reloadTodayWeatherView = todayDetailView.updateUI
        viewModel.showLocationAlertView = showLocationDisableAlertView
        viewModel.navigationBarTitleChanged = navigationTitleChanged
        viewModel.locationPermissionReady = locationPermissionReady
        return viewModel
    }()
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        scrollView.isHidden = true
        lottieView.play()
        viewModel.getLocationWithPermission()
    }
    
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
        }
    }
    
    // MARK: Navigation buttons
    @objc func searchTapped() {
        let vc = CitySearchViewController()
        vc.addNewCityByCoordination = changeCoordinationAndUpdate
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func favoriteTapped() {
        let vc = FavoriteListViewController()
        vc.changeCityFromFavoriteList = changeCoordinationAndUpdate
        vc.addNewCityByCoordination = changeCoordinationAndUpdate
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: Pull To Refresh
    @objc func didPullToRefresh() {
        viewModel.pullToRefresh() {
            self.refreshControl.endRefreshing()
        }
    }
    
    func dailyDetailView(_ show: Bool) {
        let animator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 0.7) {
            self.heightOfDailyView.constant = show ? 400 : 200
            self.dailyWeatherView.superview?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    // MARK: Location Alert
    func showLocationDisableAlertView() {
        let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup All Views
extension HomeViewController {
    private func setupViews() {
        view.backgroundColor = .current(color: .gradientTop)
        setupGradientView()
        setupLottieView()
        setupScrollView()
        setupCurrentWeatherView()
        setupHourlyWeatherView()
        setupDailyWeatherView()
        setupTodayDetailView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.scrollView.addSubview(refreshControl)
    }
    
    private func setupGradientView() {
        view.addSubview(holderView)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: margins.topAnchor),
            holderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            holderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            holderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        holderView.firstColor = .current(color: .gradientTop)
        holderView.secondColor = .current(color: .gradientBottom)
        holderView.endColor = .current(color: .gradientBottom)
        holderView.isHorizontal = false
    }
    
    private func setupLottieView() {
        view.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            lottieView.heightAnchor.constraint(equalTo: lottieView.widthAnchor)
        ])
    }
    
    private func setupCurrentWeatherView() {
        scrollView.addSubview(currentWeatherView)
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            currentWeatherView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            currentWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupHourlyWeatherView() {
        scrollView.addSubview(hourlyWeatherView)
        hourlyWeatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hourlyWeatherView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 15),
            hourlyWeatherView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            hourlyWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourlyWeatherView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupDailyWeatherView() {
        scrollView.addSubview(dailyWeatherView)
        
        NSLayoutConstraint.activate([
            dailyWeatherView.topAnchor.constraint(equalTo: hourlyWeatherView.bottomAnchor, constant: 15),
            dailyWeatherView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            dailyWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        heightOfDailyView = dailyWeatherView.heightAnchor.constraint(equalToConstant: 200)
        heightOfDailyView.isActive = true
    }
    
    private func setupTodayDetailView() {
        scrollView.addSubview(todayDetailView)
        todayDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayDetailView.topAnchor.constraint(equalTo: dailyWeatherView.bottomAnchor, constant: 15),
            todayDetailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            todayDetailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayDetailView.heightAnchor.constraint(equalToConstant: 410),
            todayDetailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
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
