//
//  FoodItemsViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class FoodItemsTableViewController: UITableViewController {

    var foodItems: [FoodItem] = []

    //MARK: - View Controller's life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: "FoodItemCell")
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell
        let foodItem = foodItems[indexPath.row]
        cell.configure(with: foodItem)
        return cell
    }
    
    //MARK: - TableView DataDelegate Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
