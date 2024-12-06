//
//  MoviesViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/2/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let tableView = UITableView()
    var movies: [Movies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view.backgroundColor = .white
        
        tableView.register(TranscodingTableViewCell.self, forCellReuseIdentifier: "TranscodingCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        fetchMovies()
        
    }
    
    func fetchMovies() {
        let urlString = "https://gist.githubusercontent.com/dbackeus/484315/raw/dfeb530f9619bb74af5d537280a0b3b305410d01/videos.json"
        
        NetworkManager.shared.fetchData(from: urlString) { (result: Result<[Movies], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.movies = response
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}


extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies[section].transcodings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TranscodingCell", for: indexPath) as? TranscodingTableViewCell else {
            return UITableViewCell()
        }
        let transcoding = movies[indexPath.section].transcodings[indexPath.row]
        cell.configure(with: transcoding)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let movie = movies[section]
        return "Movie: \(movie.title) | Duration: \(movie.duration) seconds"
    }
}


