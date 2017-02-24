//
//  PostTableViewCell.swift
//  BottomText
//
//  Created by Tyler Milner on 2/16/17.
//  Copyright © 2017 Tyler Milner. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func configure(with post: AllPostsQuery.Data.Post) {
//        textView.text = post.body
//    }
}
