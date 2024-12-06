//
//  CountriesViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import UIKit

class CountriesViewController: UIViewController {
    let tableView = UITableView()
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Countries"
        
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
     
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        fetchCountries()
    }
    
    func fetchCountries() {
        let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        NetworkManager.shared.fetchData(from: urlString) { (result: Result<[Country], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching countries: \(error)")
                }
            }
        }
    }
}


extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let country = countries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCountry = countries[indexPath.row]
        let detailVC = CountryDetailViewController()
        detailVC.country = selectedCountry
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
