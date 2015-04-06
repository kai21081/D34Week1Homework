//
//  Tweet.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 3. 30..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class Tweet{
  
  var text: String
  var userName: String
  var id: String
  var fullText: String?
  var retweetCount: String
  var favoriteCount: String
  var profileImage: UIImage?
  var profileImageURL: String
  var screen_name : String
  
  init(userName: String, text: String, id: String, retweetCount: String, favoriteCount: String, profileImageURL: String, screenName: String){
    self.userName = userName
    self.text = text
    self.id = id
    self.retweetCount = retweetCount
    self.favoriteCount = favoriteCount
    self.profileImageURL = profileImageURL
    self.screen_name = screenName
  }
}