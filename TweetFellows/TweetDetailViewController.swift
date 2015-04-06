//
//  TweetDetailViewController.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 4. 3..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

  @IBOutlet weak var profileImage: UIButton!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var fullTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favCountLabel: UILabel!
  var tweet : Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.userNameLabel.text = tweet.userName
    self.fullTextLabel.text = tweet.fullText
    self.retweetCountLabel.text = tweet.retweetCount
    self.favCountLabel.text = tweet.favoriteCount
    self.profileImage.setBackgroundImage(tweet.profileImage, forState: UIControlState.Normal)
  }
  @IBAction func imageButtonPressed(sender: AnyObject) {
    var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("UserTimelineView") as UserTimelineViewController
    viewController.tweet = tweet
    self.navigationController?.pushViewController(viewController, animated: true)

  }

}
