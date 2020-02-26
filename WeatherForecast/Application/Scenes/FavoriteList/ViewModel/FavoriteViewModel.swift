//
//  FavoriteViewModel.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/25/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation

class FavoriteViewModel: NSObject {
    var reloadData: (() -> ())?
    // MARK: - Private Properties
    private var currentLocation: Coordinate!

    // Update weather data by selecting new city
    func updateWeatherByNewCoordinate(coordinate: Coordinate) {
        currentLocation = coordinate
        fetchDataByCoordinate(location: coordinate)
    }
    
    // Fetching Current Weather data in Favorirte controller
    private func fetchDataByCoordinate(location: Coordinate, onCompletion: (() -> ())? = nil) {
        let dispatchGroup = DispatchGroup()
        let session = URLSession.shared
        let networkLayer = NetworkLayer(session: session)
        
        dispatchGroup.enter()
        networkLayer.request(router: .getWeather(lat: location.lat, lon: location.lon)) { [weak self] (result: Result<CurrentWeatherModel, Error>) in
            switch result {
            case .success(let dataModel):
                self?.reloadData?()
                CacheManager.shared.saveNewCity(city: dataModel)
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
}
