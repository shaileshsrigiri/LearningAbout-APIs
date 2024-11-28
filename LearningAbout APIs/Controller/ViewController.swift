//
//  ViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var todos: [Todo] = []
    let todoService = MockTodoService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchTodoData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    func fetchTodoData() {
        todos = todoService.fetchTodos()
        tableView.reloadData()
    }
    
}





extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = "ID: \(todo.id) - \(todo.title)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}



extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTodo = todos[indexPath.row]
        let alert = UIAlertController(title: "Todo Details",
                                      message: "ID: \(selectedTodo.id) - \(selectedTodo.title)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
