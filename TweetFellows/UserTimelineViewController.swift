//
//  UserTimelineViewController.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 4. 3..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var profileImageView: UIImageView!
  var tweets = [Tweet]()
  var tweet : Tweet!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.tableView.delegate = self
      self.tableView.dataSource = self
      let tableCellNib = UINib(nibName: "TwitterTableViewCell", bundle: NSBundle.mainBundle())
      self.tableView.registerNib(tableCellNib, forCellReuseIdentifier: "TweetCell")
      self.tableView.estimatedRowHeight = 70
      self.tableView.rowHeight = UITableViewAutomaticDimension
      self.activityIndicator.startAnimating()
      self.tableView.userInteractionEnabled = false
      
      profileImageView.image = tweet.profileImage
      TwitterService.sharedService.fetchUserTimeline(tweet.screen_name, { (data, errorDescription) -> Void in
        if errorDescription != nil{
          println(errorDescription)
          //error handling
        }else{
          if data != nil{
            self.activityIndicator.stopAnimating()
            self.tableView.userInteractionEnabled = true
            self.tweets = TweetJSONParser.tweetsFromJSONData(data!)
            self.tableView.reloadData()
          }
        }
        

    })
  }
  
  //MARK:
  //MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TwitterTableViewCell
    let selectedTweet = tweets[indexPath.row]
    cell.tweetTextLabel.text = selectedTweet.text
    cell.userNameLabel.text = selectedTweet.userName
    cell.retweetCountLabel.text = selectedTweet.retweetCount
    cell.favoritesCountLabel.text = selectedTweet.favoriteCount

    cell.profileImageView.image = tweet.profileImage
    
    //infinite scrolling
    if tweets.count - indexPath.row == 10{
      if let lastTweet = tweets.last{
        TwitterService.sharedService.fetchTweetsOlderThan(lastTweet, { (data, errorDescription) -> Void in
          if errorDescription != nil{
            println(errorDescription)
            //error handling
          }else{
            if data != nil{
              let newTweets = TweetJSONParser.tweetsFromJSONData(data!)
              for var i = 0; i < newTweets.count; ++i{
                self.tweets.append(newTweets[i])
              }
              self.tableView.reloadData()
            }
          }
        })
      }

    }
    return cell
  }
  
  //MARK:
  //MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }

}
