//
//  Movies.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/2/24.
//

import Foundation

struct Movies: Codable {
    let id: String
    let title: String
    let duration: Double
    let transcodings: [Transcodings]
    
}

struct Transcodings: Codable {
    let id: String
    let rtmp_stream_uri: String
    let size: Int
    let http_uri: String
    let title: String
    let progress: Double
    let rtmp_base_uri: String
    let bitrate: Int
    let height: Int
    let rtmp_uri: String
    let state: String
    let width: Int
}



