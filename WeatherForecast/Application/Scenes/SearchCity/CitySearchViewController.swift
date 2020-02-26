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
        searchBar.searchBarStyle = .prominent
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Add City"
        return searchBar
    }()
    private lazy var tableView = UITableView()
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
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    // MARK: - Methods
    private func setupViews() {
        self.view.backgroundColor = .current(color: .background)
        prepareSearchBar()
        prepareCollectionView()
        fetchCities()
    }
    
    private func fetchCities() {
        DispatchQueue.global().async {
            if let cities = self.loadJson(filename: "cityList") {
                self.citiesList = cities
            } else {
                print("Error: We have problem in parsing cities data")
            }
        }
    }
    
    private func prepareSearchBar() {
        view.addSubview(searchBar)
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: margins.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        searchBar.delegate = self
    }
    
    private func prepareCollectionView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        self.tableView.register(SearchCityCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.backgroundColor = .current(color: .background)
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = true
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
