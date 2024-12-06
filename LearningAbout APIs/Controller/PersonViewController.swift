//
//  PersonViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//

import UIKit

class PersonViewController: UIViewController {
    
    var nameLabel = UILabel()
    var heightLabel = UILabel()
    var massLabel = UILabel()
    var hairColorLabel = UILabel()
    var skinColorLabel = UILabel()
    var eyeColorLabel = UILabel()
    var birthYearLabel = UILabel()
    var genderLabel = UILabel()
    var createdLabel = UILabel()
    var editedLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Person"
        setupUI()
        fetchPersonData()
    }
    
    
    func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, heightLabel, massLabel, hairColorLabel, skinColorLabel,
            eyeColorLabel, birthYearLabel, genderLabel, createdLabel, editedLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
    
    func fetchPersonData() {
        let urlString = "https://swapi.py4e.com/api/people/1/"
        
        NetworkManager.shared.fetchData(from: urlString) { (result: Result<Person, NetworkError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let person):
                    self.updateUI(with: person)
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
    
    func updateUI(with person: Person) {
        nameLabel.text = "Name: \(person.name)"
        heightLabel.text = "Height: \(person.height)"
        massLabel.text = "Mass: \(person.mass)"
        hairColorLabel.text = "Hair Color: \(person.hair_color)"
        skinColorLabel.text = "Skin Color: \(person.skin_color)"
        eyeColorLabel.text = "Eye Color: \(person.eye_color)"
        birthYearLabel.text = "Birth Year: \(person.birth_year)"
        genderLabel.text = "Gender: \(person.gender)"
        createdLabel.text = "Created: \(dateFormatter(person.created))"
        editedLabel.text = "Edited: \(dateFormatter(person.edited))"
    }
    
    //https://medium.com/mobile-app-development-publication/mastering-date-formatting-in-swift-979ffae19ca8
    func dateFormatter(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
        return "Invalid Date"
        }
    }
    
}
