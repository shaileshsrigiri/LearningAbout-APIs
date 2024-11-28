//
//  TodoService.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import Foundation

class TodoService {
    var todos: [Todo] = []
    
    func fetchTodos() {
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                self.todos = try JSONDecoder().decode([Todo].self, from: data)
                print("Fetched Todos: \(self.todos.count)")
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

