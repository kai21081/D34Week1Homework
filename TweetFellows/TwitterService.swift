//
//  TwitterService.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 4. 1..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService{
  
  class var sharedService: TwitterService{
    struct Static{
      static let instance : TwitterService = TwitterService()
    }
    return Static.instance
  }
  
  var twitterAccount : ACAccount?
  var homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  var tweetDetailURL = "https://api.twitter.com/1.1/statuses/show.json?id="
  var userTimelineURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
  var tweetsOlderThanIDURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?max_id="

  init(){
    
  }
  
  func fetchHomeTimeline(completionHandler : (NSData?,NSString?) -> Void){
    let requestURL = NSURL(string: homeTimelineURL)
    var twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil{
        //check error
      }else{
        //check HTTP response for any service error
        var errorDesc : String?
        switch(response.statusCode){
        case 200...299:
          // response is good. send data back to controller
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
             completionHandler(data,nil)
          })
        case 400...499:
          errorDesc = "Please check the url"
        case 500...599:
          errorDesc = "Server is down"
        default:
          errorDesc = "Try again"
        }
        if errorDesc != nil{
          //send error message back to controller
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(nil,errorDesc)
          })

        }
      }
    }
    
  }
  
  func showDetailTweet(id : String, completionHandler: (String?,String?) -> Void){
    var fullText : String?
    var tweetDetailURLForID = tweetDetailURL + id
    let requestURL = NSURL(string: tweetDetailURLForID)
    var twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil{
        //check error
      }else{
        //check HTTP response for any service error
        var errorDesc : String?
        switch(response.statusCode){
        case 200...299:
          fullText = TweetJSONParser.tweetDetailFromJSONData(data);
        case 400...499:
          errorDesc = "Please check the url"
        case 500...599:
          errorDesc = "Server is down"
        default:
          errorDesc = "Try again"
        }
        //send error message back to controller
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(fullText, errorDesc)
        })
      }
    }

  }
  
  func fetchUserTimeline(userName: String, completionHandler: (NSData?, String?)-> Void){
    var userTimelineURLForUsername = userTimelineURL + userName
    let requestURL = NSURL(string: userTimelineURLForUsername)
    var twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil{
        var bp = 1
        //check error
      }else{
        //check HTTP response for any service error
        var errorDesc : String?
        switch(response.statusCode){
        case 200...299:
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(data,nil)
          })
        case 400...499:
          errorDesc = "Please check the url"
        case 500...599:
          errorDesc = "Server is down"
        default:
          errorDesc = "Try again"
        }
        //send error message back to controller
        if errorDesc != nil{
          //send error message back to controller
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(nil,errorDesc)
          })
          
        }
      }
    }
  }
  
  func fetchTweetsOlderThan(tweet: Tweet, completionHandler: (NSData?, String?)-> Void){
    var tweetsOlderThanIDURLForID = userTimelineURL + tweet.screen_name+"&max_id="+tweet.id
    let requestURL = NSURL(string: tweetsOlderThanIDURLForID)
    var twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil{
        var bp = 1
        //check error
      }else{
        //check HTTP response for any service error
        var errorDesc : String?
        switch(response.statusCode){
        case 200...299:
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(data,nil)
          })
        case 400...499:
          errorDesc = "Please check the url"
        case 500...599:
          errorDesc = "Server is down"
        default:
          errorDesc = "Try again"
        }
        //send error message back to controller
        if errorDesc != nil{
          //send error message back to controller
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(nil,errorDesc)
          })
        }
      }
    }
  }
}
