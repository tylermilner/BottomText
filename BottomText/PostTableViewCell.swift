//
//  PostTableViewCell.swift
//  BottomText
//
//  Created by Tyler Milner on 2/16/17.
//  Copyright © 2017 Tyler Milner. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    // MARK: - Public
    
    func configure(with post: AllPostsQuery.Data.AllPost) {
        textView.text = post.body
    }
}
