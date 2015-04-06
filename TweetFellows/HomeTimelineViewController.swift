//
//  ViewController.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 3. 30..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit


class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var twitterTableViewCellNib = UINib(nibName: "TwitterTableViewCell", bundle: NSBundle.mainBundle())
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.registerNib(twitterTableViewCellNib, forCellReuseIdentifier: "TweetCell")
    self.tableView.userInteractionEnabled = false
    self.tableView.estimatedRowHeight = 70
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.activityIndicator.startAnimating()
    
    
    
    AccountService.fetchAccount { (twitterAccount, errorDescription) -> Void in
      println(errorDescription)
      if twitterAccount != nil{
        TwitterService.sharedService.twitterAccount = twitterAccount
        TwitterService.sharedService.fetchHomeTimeline({ (data, errorDescription) -> Void in
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
    }
  }
  
  //MARK:
  //MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TwitterTableViewCell
    let tweet = tweets[indexPath.row]
    cell.tweetTextLabel.text = tweet.text
    cell.userNameLabel.text = tweet.userName
    cell.retweetCountLabel.text = tweet.retweetCount
    cell.favoritesCountLabel.text = tweet.favoriteCount
    
    if tweet.profileImage == nil{
      if let requestURL = NSURL(string:tweet.profileImageURL){
        if let imageData = NSData(contentsOfURL: requestURL){
          tweet.profileImage = UIImage()
          tweet.profileImage = UIImage(data: imageData)
          cell.profileImageView.image = tweet.profileImage
        }
      }
    }else{
      cell.profileImageView.image = tweet.profileImage
    }
    
    return cell
  }
  
  //MARK:
  //MARK: UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    TwitterService.sharedService.showDetailTweet(tweets[indexPath.row].id, completionHandler: { (fullText, error) -> Void in
      if error != nil{
        //handle error
      }else{
        self.tweets[indexPath.row].fullText = fullText
        if fullText == nil{
          self.tweets[indexPath.row].fullText = self.tweets[indexPath.row].text
        }
        let selectedTweet = self.tweets[indexPath.row]
        var tweetDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TweetDetailView") as TweetDetailViewController
        tweetDetailViewController.tweet = selectedTweet
        self.navigationController?.pushViewController(tweetDetailViewController, animated: true)
      }
          })
  }


}

