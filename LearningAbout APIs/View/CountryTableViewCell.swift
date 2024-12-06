//
//  CountryTableViewCell.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import UIKit

class CountryTableViewCell: UITableViewCell {
    let flagImageView = UIImageView()
    let nameLabel = UILabel()
    let capitalLabel = UILabel()
    let regionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        flagImageView.contentMode = .scaleAspectFit
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        capitalLabel.font = UIFont.systemFont(ofSize: 14)
        regionLabel.font = UIFont.systemFont(ofSize: 14)
        regionLabel.textColor = .gray
        
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(capitalLabel)
        contentView.addSubview(regionLabel)
        
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            flagImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 50),
            flagImageView.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            capitalLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            regionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            regionLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 5),
            regionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital ?? "Unknown")"
        regionLabel.text = "Region: \(country.region)"

        if let url = URL(string: country.flag) {
            ImageLoader.loadImage(from: url, into: flagImageView)
        } else {
            print("Invalid URL: \(country.flag)")
            flagImageView.image = UIImage(systemName: "photo")
        }
    }
}
