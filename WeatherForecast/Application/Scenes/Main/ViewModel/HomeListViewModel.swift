//
//  HomeListViewModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/24/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation
import CoreLocation

class HomeListViewModel: NSObject {
    // MARK: - Public Properties
    var reloadCurrentWeatherView: ((CurrentWeatherModel) -> ())?
    var reloadHourlyWeatherView: ((ForecastHourlyModel) -> ())?
    var reloadDailyWeatherView: ((ForecastDailyModel) -> ())?
    var reloadTodayWeatherView: ((CurrentWeatherModel) -> ())?
    var showLocationAlertView: (() -> ())?
    var navigationBarTitleChanged: ((String) -> ())?
    var locationPermissionReady: (() -> ())?
    var locationNotAvailable: (() -> ())?
    // MARK: - Private Properties
    private var currentLocation: Coordinate!
    private let locationManager = CLLocationManager()
    // MARK:- API Funcs
    func updateWeatherByNewCoordinate(coordinate: Coordinate) {
        currentLocation = coordinate
        fetchDataByCoordinate(location: coordinate)
        
    }
    
    // Response to the Refresh Controller
    func pullToRefresh(onCompletion: @escaping (() -> Void)) {
        fetchDataByCoordinate(location: currentLocation) {
            onCompletion()
        }
    }
    
    private func fetchDataByCoordinate(location: Coordinate, onCompletion: (() -> ())? = nil) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
    
        let session = URLSession.shared
        let networkLayer = NetworkLayer(session: session)
        
        networkLayer.request(router: .getWeather(lat: location.lat, lon: location.lon)) { [weak self] (result: Result<CurrentWeatherModel, Error>) in
            switch result {
            case .success(let dataModel):
                self?.reloadCurrentWeatherView?(dataModel)
                self?.reloadTodayWeatherView?(dataModel)
                self?.navigationBarTitleChanged?(dataModel.name)
                CacheManager.shared.saveNewCity(city: dataModel)
                CacheManager.shared.saveMyFavoriteCity(city: dataModel)
                dispatchGroup.leave()
            case .failure:
                print(result)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        networkLayer.request(router: .hourlyWeather(lat: location.lat, lon: location.lon)) { [weak self] (result: Result<ForecastHourlyModel, Error>) in
            switch result {
            case .success(let dataModel):
                self?.reloadHourlyWeatherView?(dataModel)
                dispatchGroup.leave()
            case .failure:
                print(result)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        networkLayer.request(router: .dailyWeather(lat: location.lat, lon: location.lon)) { [weak self] (result: Result<ForecastDailyModel, Error>) in
            switch result {
            case .success(let dataModel):
                self?.reloadDailyWeatherView?(dataModel)
                dispatchGroup.leave()
            case .failure:
                print(result)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            onCompletion?()
        }
    }
    // MARK: - Location
    func getLocationWithPermission() {
        self.locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        handleLocationPermissionStatus(status: status)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func handleLocationPermissionStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showLocationAlertView?()
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = fetchCurrentLocation() {
                currentLocation = location
                locationPermissionReady?()
            } else {
                locationNotAvailable?()
            }
        @unknown default:
            assertionFailure("Problem in status of location manager")
        }
    }
    
    private func fetchCurrentLocation() -> Coordinate? {
        var location: Coordinate?
        if let currentLoc = locationManager.location {
            location = Coordinate(lon: currentLoc.coordinate.longitude, lat: currentLoc.coordinate.latitude)
        }
        return location
    }
}

// MARK: Location manager delegate
extension HomeListViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationPermissionStatus(status: status)
    }
}
