//
//  FoodGroupsViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class FoodGroupsTableViewController: UITableViewController {

    // MARK: - Properties
    var foodGroups: [FoodGroup] = []
    let progressView = UIProgressView(progressViewStyle: .default)

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food Groups"
        setupTableView()
        setupProgressView()
        fetchFoodGroups()
    }
    
    private func setupTableView() {
        tableView.register(FoodGroupCell.self, forCellReuseIdentifier: "FoodGroupCell")
    }
    
    func setupProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }

    //MARK: - API Method
    func fetchFoodGroups() {
        let urlString = APIEndpoints.foodDataURL
 
        progressView.setProgress(0.2, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.progressView.setProgress(0.5, animated: true)
        }
        
        NetworkManager.shared.fetchData(from: urlString) { (result: Result<FoodGroupsResponse, NetworkError>) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.progressView.setProgress(1.0, animated: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                switch result {
                case .success(let response):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.progressView.setProgress(1.0, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.progressView.isHidden = true
                        }
                    }
                    self.foodGroups = response.food_groups!
                    self.reloadTableView()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodGroupCell", for: indexPath) as! FoodGroupCell
        let foodGroup = foodGroups[indexPath.row]
        cell.configure(with: foodGroup)
        return cell
    }

    //MARK: - TableView DataDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFoodGroup = foodGroups[indexPath.row]
        navigateToFoodItems(for: selectedFoodGroup)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Navigation
    private func navigateToFoodItems(for foodGroup: FoodGroup) {
        let foodItemsVC = FoodItemsTableViewController()
        foodItemsVC.foodItems = foodGroup.food_items!
        foodItemsVC.title = foodGroup.name
        navigationController?.pushViewController(foodItemsVC, animated: true)
    }
}
