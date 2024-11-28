//
//  CountryViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//

import UIKit

class CountryViewController: UIViewController {
    
    let tableView = UITableView()
    var countries: [Country] = []
    let countryService = CountryService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCountryData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchCountryData() {
        countryService.fetchCountries { [weak self] countries, errorMessage in
            if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    self?.showErrorMessage(errorMessage)
                }
                return
            }
            
            if let countries = countries {
                self?.countries = countries
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = "\(country.name) - Capital: \(country.capital ?? "N/A")"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCountry = countries[indexPath.row]
        showCountryDetails(selectedCountry)
    }
    
    private func showCountryDetails(_ country: Country) {
        let message = """
        Name: \(country.name)
        Capital: \(country.capital ?? "N/A")
        Currency: \(country.currency?.name ?? "N/A") (\(country.currency?.code ?? "N/A")) - Symbol: \(country.currency?.symbol ?? "N/A")
        Language: \(country.language?.name ?? "N/A") (\(country.language?.code ?? "N/A"))
        Region: \(country.region ?? "N/A")
        """
        let alert = UIAlertController(title: country.name, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
