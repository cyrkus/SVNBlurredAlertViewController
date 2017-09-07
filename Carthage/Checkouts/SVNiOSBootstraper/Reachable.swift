//
//  Reachable.swift
//  SwiftApp
//
//  Created by Aaron bikis on 8/25/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import UIKit

public struct ReachableErrorAlert: SVNAlert {
  public var title: String = "Your internet seems to be unreachable"
  public var message: String = "Please check your connection and try again."
}


public protocol Reachable:  Alertable {}


extension Reachable where Self: UIViewController {
  /**
   Tests the user's internet connection
   - callback: isReachable *Bool* returns when the user's internet connection is ascertained
   */
  func testConnection(_ callback:@escaping (_ isReachable:Bool) ->()){
    let reachability = Reachability()!
    
    reachability.whenReachable = { reachability in
      // this is called on a background thread, but UI updates must
      // be on the main thread, like this:
      DispatchQueue.main.async {
        callback(true)
      }
    }
    reachability.whenUnreachable = { reachability in
      // this is called on a background thread, but UI updates must
      // be on the main thread, like this:
      DispatchQueue.main.async {
        self.show(alertWithType: ReachableErrorAlert(), withCompletionHandler: nil)
        callback(false)
      }
    }
    
    do {
      try reachability.startNotifier()
    } catch {
      callback(false)
    }
  }
}
