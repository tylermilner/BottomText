//
//  ViewController.swift
//  BottomText
//
//  Created by Tyler Milner on 2/16/17.
//  Copyright © 2017 Tyler Milner. All rights reserved.
//

import UIKit
import Apollo

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var tableView: UITableView!
    
//    var watcher: GraphQLQueryWatcher<AllPostsQuery>?
//    
//    var allPosts: [AllPostsQuery.Data.Post]? {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/ciyp5mu7q47df0132db4vojmp")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }

    func loadData() {
//        watcher = apollo.watch(query: AllPostsQuery()) { (result, error) in
//            if let error = error {
//                NSLog("Error while fetching query: \(error.localizedDescription)")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.allPosts = result?.data?.allPosts
//                print("allPosts: \(self.allPosts)")
//            }
//            
//        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allPosts?.count ?? 0
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            fatalError("Could not dequeue PostTableViewCell")
        }
        
//        guard let post = allPosts?[indexPath.row] else {
//            fatalError("Could not find post at row \(indexPath.row)")
//        }
//        
//        cell.configure(with: post)
        
        return cell

    }
}

