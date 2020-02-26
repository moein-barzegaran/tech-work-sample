//
//  DiskManager.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/23/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import Foundation
import Disk

class CacheManager {
    var citiesList: [CurrentWeatherModel] = []
    
    static let shared = CacheManager()
    private init(){}
    
    // Save new city into the disk
    func saveNewCity(city: CurrentWeatherModel) {
        do {
            if let cities = fetchCities() {
                if cities.contains(where: { $0.name == city.name }) { return }
            }
            try Disk.append(city, to: "cities.json", in: .caches)
            citiesList.append(city)
        } catch {
            print("Error: Problem in saving new city in the list")
        }
    }
    
    // Delete disk record by the city name
    func deleteCity(city: CurrentWeatherModel) {
        do {
            if let cities = fetchCities() {
                var array = cities
                if let index = array.firstIndex(where: { $0.name == city.name }) {
                    array.remove(at: index)
                    try Disk.remove("cities.json", from: .caches)
                    try Disk.append(array, to: "cities.json", in: .caches)
                    citiesList = array
                }
            }
        } catch {
            print("Error: Problem in saving new city in the list")
        }
    }
    
    // Fetch cities list from the disk
    func fetchCities() -> [CurrentWeatherModel]? {
        do {
            let retrievedCities = try Disk.retrieve("cities.json", from: .caches, as: [CurrentWeatherModel].self)
            citiesList = retrievedCities
            return retrievedCities
        } catch {
            print("Error: Problem in fetching cities list")
        }
        return nil
    }
    
    // Save MyFavoriteCity into the Disk
    func saveMyFavoriteCity(city: CurrentWeatherModel) {
        do {
            if let savedCity = fetchMyFavoriteCity() {
                if savedCity.name == city.name { return }
            }
            try Disk.save(city, to: .caches, as: "MyFavoriteCity.json")
        } catch {
            print("Error: Problem in saving new city in the list")
        }
    }
    
    // Fetch MyFavoriteCity from Disk
    func fetchMyFavoriteCity() -> CurrentWeatherModel? {
        do {
            let retrievedCity = try Disk.retrieve("MyFavoriteCity.json", from: .caches, as: CurrentWeatherModel.self)
            return retrievedCity
        } catch {
            print("Error: Problem in fetching cities list")
        }
        return nil
    }
}
