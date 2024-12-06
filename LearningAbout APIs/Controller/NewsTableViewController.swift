//
//  NewsViewController.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//


import UIKit

class NewsTableViewController: UITableViewController {
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        fetchNews()
    }
    
    func fetchNews() {
        let urlString = "https://gist.githubusercontent.com/congsun/600f3ad57298f9dbc23fedf6b2b25450/raw/73d7a8ed589652339ae3646d0a595298ce5e72c2/newsFeed.json"

        NetworkManager.shared.fetchData(from: urlString) { [weak self] (result: Result<NewsFeed, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let newsFeed):
                    self?.articles = newsFeed.articles
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching news: \(error)")
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let detailVC = NewsDetailViewController()
        detailVC.article = article
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
