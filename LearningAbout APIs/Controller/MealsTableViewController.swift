//
//  MealsViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class MealsTableViewController: UITableViewController {

    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meals"
        tableView.register(MealCell.self, forCellReuseIdentifier: "MealCell")
        fetchMeals()
    }

    func fetchMeals() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?f=s"
        
        NetworkManager.shared.fetchData(from: urlString) { (result: Result<MealResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.meals = response.meals
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        let meal = meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        let detailVC = MealDetailViewController()
        detailVC.meal = meal
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
