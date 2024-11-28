//
//  MockTodoService.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import Foundation

class MockTodoService {
    func fetchTodos() -> [Todo] {
        return [
            Todo(userId: 1, id: 1, title: "Complete Swift project", completed: true),
            Todo(userId: 1, id: 2, title: "Go to the gym", completed: false),
            Todo(userId: 2, id: 3, title: "Buy groceries", completed: true),
            Todo(userId: 2, id: 4, title: "Prepare dinner", completed: false),
            Todo(userId: 3, id: 5, title: "Finish reading book", completed: true)
        ]
    }
}
