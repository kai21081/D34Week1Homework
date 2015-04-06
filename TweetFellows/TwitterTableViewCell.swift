//
//  TwitterTableViewCell.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 4. 1..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!

  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoritesCountLabel: UILabel!
}
