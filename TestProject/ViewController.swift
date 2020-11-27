//
//  ViewController.swift
//  TestProject
//
//  Created by Sahil Behl on 2020-11-22.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var newsArray = [News]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        
        let newsAPI = GetNewsAPI()
        newsAPI.fetchNews(failure: nil, success: {
            self.newsArray = $0
        })
        
        tableView.register(NewsStoryTableViewCell.self, forCellReuseIdentifier: String(describing: NewsStoryTableViewCell.self))
    }
    
    private func design() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewLeadingAnchor = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let tableViewTrailingAnchor = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        let tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([tableViewLeadingAnchor, tableViewTrailingAnchor, tableViewTopAnchor, tableViewBottomAnchor])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsStoryTableViewCell.self), for: indexPath) as? NewsStoryTableViewCell else {
            return UITableViewCell()
        }
        let news = newsArray[indexPath.row]
        cell.configure(data: NewsStoryTableViewCell.Data(titleText: news.title, descriptionText: news.text))
        return cell
    }
    
    
}

