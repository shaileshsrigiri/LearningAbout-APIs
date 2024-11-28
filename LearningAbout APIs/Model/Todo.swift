//
//  Todo.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
