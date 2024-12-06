//
//  FoodItemCell.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class FoodItemCell: UITableViewCell {

    let itemImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .blue

        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(itemImageView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 60),
            itemImageView.heightAnchor.constraint(equalToConstant: 60),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            stackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with foodItem: FoodItem) {
        nameLabel.text = foodItem.name
        descriptionLabel.text = foodItem.description
        if let price = foodItem.price {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = "Price not available"
        }
        if let imageUrl = foodItem.image_url, let url = URL(string: imageUrl) {
                ImageLoader.loadImage(from: url, into: itemImageView)
        } else {
                itemImageView.image = UIImage(named: "placeholder")
        }
    }
}
