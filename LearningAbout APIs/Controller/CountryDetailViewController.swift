//
//  CountryDetailViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import UIKit

class CountryDetailViewController: UIViewController {
    var country: Country?

    let nameLabel = UILabel()
    let capitalLabel = UILabel()
    let currencyLabel = UILabel()
    let languageLabel = UILabel()
    let flagImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        populateData()
    }

    func setupUI() {
        
        view.addSubview(nameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(currencyLabel)
        view.addSubview(languageLabel)
        view.addSubview(flagImageView)

        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 100),
            flagImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            capitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            currencyLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 20),
            currencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            languageLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 20),
            languageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func populateData() {
        guard let country = country else { return }

        nameLabel.text = "Name: \(country.name)"
        capitalLabel.text = "Capital: \(country.capital ?? "Unknown")"
        
        let currencyName = country.currency.name ?? "Unknown"
        let currencySymbol = country.currency.symbol ?? "N/A"
        currencyLabel.text = "Currency: \(currencyName) (\(currencySymbol))"
        
        let languageName = country.language.name ?? "Unknown"
        languageLabel.text = "Language: \(languageName)"

        if let url = URL(string: country.flag) {
            ImageLoader.loadImage(from: url, into: flagImageView)
        } else {
            flagImageView.image = UIImage(systemName: "photo")
        }
    }

}
