//
//  TweetJSONParser.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 3. 30..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func tweetsFromJSONData(data : NSData) -> [Tweet]{
    var tweets = [Tweet]()
    var error: NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [[String: AnyObject]]{
      for object in jsonObject{
        if let text = object["text"] as? String{
          if let id = object["id_str"] as? String{
            if let retweetCount = object["retweet_count"] as? Int{
              if let user = object["user"] as? [String:AnyObject]{
                if let userName = user["name"] as? String{
                  if let screenName = user["screen_name"] as? String{
                    if let favCounts = user["favourites_count"] as? Int{
                      if let profileImageURL = user["profile_image_url_https"] as? String{
                        let tweet = Tweet(userName: userName, text: text, id: id, retweetCount: "\(retweetCount)", favoriteCount: "\(favCounts)", profileImageURL: profileImageURL, screenName: screenName)
                          tweets.append(tweet)
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return tweets
  }
  
  class func tweetDetailFromJSONData(data : NSData) -> String?{
    var error: NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String: AnyObject]{
      if let retweet = jsonObject["retweeted_status"] as? [String:AnyObject]{
        if let fullText = retweet["text"] as? String{
          return fullText
        }
      }
    }
    return nil
  }
}