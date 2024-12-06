//
//  MealDetailViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class MealDetailViewController: UIViewController {

    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        guard let meal = meal else { return }

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if let url = URL(string: meal.strMealThumb) {
            ImageLoader.loadImage(from: url, into: imageView)
        }

        let nameLabel = UILabel()
        nameLabel.text = meal.strMeal
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0

        let instructionsLabel = UILabel()
        instructionsLabel.text = meal.strInstructions
        instructionsLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, instructionsLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}
