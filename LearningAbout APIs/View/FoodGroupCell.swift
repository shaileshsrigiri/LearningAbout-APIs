//
//  FoodGroupCell.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class FoodGroupCell: UITableViewCell {

    let groupImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray

        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(groupImageView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            groupImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupImageView.widthAnchor.constraint(equalToConstant: 60),
            groupImageView.heightAnchor.constraint(equalToConstant: 60),
            groupImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            stackView.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with foodGroup: FoodGroup) {
        nameLabel.text = foodGroup.name
        descriptionLabel.text = foodGroup.description
        if let imageUrl = foodGroup.image_url, let url = URL(string: imageUrl) {
            ImageLoader.loadImage(from: url, into: groupImageView)
        } else {
            groupImageView.image = UIImage(named: "placeholder")
        }
    }
}
