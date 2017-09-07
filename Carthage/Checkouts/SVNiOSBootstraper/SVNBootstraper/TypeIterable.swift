//
//  TypeIterable.swift
//  SVNBootstraper
//
//  Created by Aaron Dean Bikis on 6/23/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation

public protocol TypeIterable {
  func allProperties() throws -> [String: Any]
}

extension TypeIterable {
  public func allProperties() throws -> [String: Any] {
    
    var result: [String: Any] = [:]
    
    let mirror = Mirror(reflecting: self)
    
    // Optional check to make sure we're iterating over a struct or class
    guard let style = mirror.displayStyle, style == .struct || style == .class else {
      throw NSError()
    }
    
    for (property, value) in mirror.children {
      guard let property = property else {
        continue
      }
      
      result[property] = value
    }
    
    return result
  }
}
