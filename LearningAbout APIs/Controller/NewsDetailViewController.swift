//
//  NewsDetailViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class NewsDetailViewController: UIViewController {
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        guard let article = article else { return }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            ImageLoader.loadImage(from: url, into: imageView)
        } else {
            imageView.image = UIImage(systemName: "photo")
        }

        let titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0

        let descriptionLabel = UILabel()
        descriptionLabel.text = article.description
        descriptionLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
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
