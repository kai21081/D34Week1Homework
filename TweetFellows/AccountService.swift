//
//  AccountService.swift
//  TweetFellows
//
//  Created by Jisoo Hong on 2015. 4. 1..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import Foundation
import Accounts

class AccountService{
  
  class func fetchAccount(completionHandler : (ACAccount?,NSString?) -> Void){
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if granted && error == nil {
        if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount]{
          if accounts.count != 0 {
            let twitterAccount = accounts.first
            completionHandler(twitterAccount,nil)
          }
        }
      }else{
        completionHandler(nil,"Please login to your twitter account")
      }
    }
    
  }
}
