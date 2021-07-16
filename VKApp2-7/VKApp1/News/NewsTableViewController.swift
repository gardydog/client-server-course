//
//  NewsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 01.06.2021.
//

import UIKit
import FirebaseDatabase

class NewsTableViewController: UITableViewController {
    
    let NewsTableViewCell = "NewsTableViewCell"
    let networkservice = NetworkService()
    let ref = Database.database().reference(withPath: "news/\(Session.shared.userId)")
    
    var news = [FirebaseNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNews()

    }
    
    func setNews() {
        networkservice.loadNews()
        
        ref.observe(.value, with: { [weak self] snapshot in
            guard let self = self else { return }
            var news: [FirebaseNewsModel] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let new = FirebaseNewsModel(snapshot: snapshot) {
                    news.append(new)
                }
            }
            self.news = news
            self.tableView.reloadData()
            
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell, for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }

        let news = news[indexPath.row]
        cell.configure(news: news)
        
        return cell
    }

  
}
