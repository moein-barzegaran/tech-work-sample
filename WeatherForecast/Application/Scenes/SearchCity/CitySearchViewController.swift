//
//  CitySearchViewController.swift
//  WeatherForecast
//
//  Created by Moein Barzegaran on 2/22/20.
//  Copyright © 2020 Moein Barzegaran. All rights reserved.
//

import UIKit
import MapKit

class CitySearchViewController: UIViewController, UISearchBarDelegate {
    // MARK: - Views
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: margins.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Add City"
        return searchBar
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            table.leftAnchor.constraint(equalTo: margins.leftAnchor),
            table.rightAnchor.constraint(equalTo: margins.rightAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        table.register(SearchCityCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        table.backgroundColor = .current(color: .background)
        table.estimatedRowHeight = 100
        table.allowsSelection = true
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.delegate = self
        table.dataSource = self
        return table
    }()
    // MARK: - Private Properties
    private let cellReuseIdentifier = "SearchCell"
    private var searchResultArray: [City] = [] {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    }
    private var citiesList: [City] = []
    // MARK: - Public Properties
    var addNewCityByCoordination: ((Coordinate) -> ())?
    
    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .current(color: .background)
        fetchCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    // MARK: - Methods
    private func fetchCities() {
        DispatchQueue.global().async {
            if let cities = self.loadJson(filename: "cityList") {
                self.citiesList = cities
            } else {
                print("Error: We have problem in parsing cities data")
            }
        }
    }

    func loadJson(filename fileName: String) -> [City]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    // MARK: - Search bar Delegates
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let cities = citiesList.filter({ $0.name.contains(searchText)})
        searchResultArray = cities
    }
}

// MARK: - Table View Data Source Delegates
extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SearchCityCell
        cell.titleLabel.text = "\(searchResultArray[indexPath.row].name), \(searchResultArray[indexPath.row].country)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchResultArray[indexPath.row]
        self.addNewCityByCoordination?(city.coord)
        self.dismiss(animated: true, completion: nil)
    }
}
