//
//  ViewController.swift
//  BottomText
//
//  Created by Tyler Milner on 2/16/17.
//  Copyright © 2017 Tyler Milner. All rights reserved.
//

import UIKit
import Apollo
import Chester

public final class AllPostsQuery: GraphQLQuery {
    
    public static var operationDefinition =
        "query AllPosts {" + // Our namespaced query
            "  allPosts {" + // Post that the server knows (via web interface)
            "    id" +
            "    body" +
            "    createdAt" +
            "    author {" +
            "        id" +
            "        name" +
            "    }" +
            "  }" +
        "}"
    
    public static let queryDocument = operationDefinition
    
    public init() {
    }
    
    public struct Data : GraphQLMappable {
        public let allPosts: [Post]
        
        public init(reader: GraphQLResultReader) throws {
            allPosts = try reader.list(for: Field(responseName: "allPosts"))
        }
        
        public struct Post: GraphQLMappable {
            let id: String
            let body: String
            let createdAt: String // ISO date
            let author: Author
            
            public init(reader: GraphQLResultReader) throws {
                id = try reader.value(for: Field(responseName: "id"))
                body = try reader.value(for: Field(responseName: "body"))
                createdAt = try reader.value(for: Field(responseName: "createdAt"))
                author = try reader.value(for: Field(responseName: "author"))
            }
            
            struct Author: GraphQLMappable {
                public let id: String
                public let name: String
                
                public init(reader: GraphQLResultReader) throws {
                    id = try reader.value(for: Field(responseName: "id"))
                    name = try reader.value(for: Field(responseName: "name"))
                }
            }
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    var watcher: GraphQLQueryWatcher<AllPostsQuery>?
    
    var allPosts: [AllPostsQuery.Data.Post]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let apollo = ApolloClient(url: URL(string: "https://api.graph.cool/simple/v1/ciyp5mu7q47df0132db4vojmp")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        loadData()
        buildQueries()
    }
    
    func buildQueries() {
        let authorQuery = try! QueryBuilder().from("author").with(fields: "id", "name")
        let allPostsQuery = try! QueryBuilder().from("allPosts").with(fields: "id", "body", "createdAt").with(subQuery: authorQuery)
        
        guard let queryString = try? allPostsQuery.build() else { fatalError("Failed to build query") }
        
        
        
    }

    func loadData() {
        watcher = apollo.watch(query: AllPostsQuery()) { (result, error) in
            if let error = error {
                NSLog("Error while fetching query: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.allPosts = result?.data?.allPosts
                print("allPosts: \(self.allPosts)")
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            fatalError("Could not dequeue PostTableViewCell")
        }
        
        guard let post = allPosts?[indexPath.row] else {
            fatalError("Could not find post at row \(indexPath.row)")
        }
        
        cell.configure(with: post)
        
        return cell

    }
}

