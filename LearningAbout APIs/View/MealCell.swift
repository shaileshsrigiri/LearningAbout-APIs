//
//  MealCell.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class MealCell: UITableViewCell {

    let mealImageView = UIImageView()
    let mealNameLabel = UILabel()
    let mealCategoryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealNameLabel.translatesAutoresizingMaskIntoConstraints = false
        mealCategoryLabel.translatesAutoresizingMaskIntoConstraints = false

        mealNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        mealCategoryLabel.font = UIFont.systemFont(ofSize: 14)
        mealCategoryLabel.textColor = .gray

        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(mealCategoryLabel)

        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mealImageView.widthAnchor.constraint(equalToConstant: 80),
            mealImageView.heightAnchor.constraint(equalToConstant: 80),
            mealImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            mealNameLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 10),
            mealNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mealNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            mealCategoryLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 10),
            mealCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mealCategoryLabel.topAnchor.constraint(equalTo: mealNameLabel.bottomAnchor, constant: 5)
        ])
    }

    func configure(with meal: Meal) {
        mealNameLabel.text = meal.strMeal
        mealCategoryLabel.text = meal.strCategory
        if let url = URL(string: meal.strMealThumb) {
            ImageLoader.loadImage(from: url, into: mealImageView)
        }
    }

}
