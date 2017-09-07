//
//  FirePrintCreatable.swift
//  SVNBootstraper
//
//  Created by Aaron Dean Bikis on 9/5/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

public protocol FinePrintAttibutedString {
  var text: String { get }
  var isLink: Bool { get }
}


public protocol FinePrintCreatable {
  func createFinePrintAttributedString(withParagraph paragraph: [FinePrintAttibutedString], linkFont: UIFont, textColor: UIColor, linkColor: UIColor, alignment: NSTextAlignment) -> NSMutableAttributedString
}

public extension FinePrintCreatable {
   func createFinePrintAttributedString(withParagraph paragraph: [FinePrintAttibutedString], linkFont: UIFont, textColor: UIColor, linkColor: UIColor, alignment: NSTextAlignment) -> NSMutableAttributedString{
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    paragraphStyle.lineBreakMode = .byWordWrapping
    paragraphStyle.lineSpacing = 0.5
    
    let attributedParagraph = NSMutableAttributedString()
    
    paragraph.forEach({
      let attStr = NSMutableAttributedString(string: $0.text)
      let range = NSMakeRange(0, attStr.length)
      attStr.addAttribute(NSForegroundColorAttributeName, value: textColor, range: range)
      
      if $0.isLink {
        let linkAttributes: [String : Any] = [NSForegroundColorAttributeName: linkColor,
                                              NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                                              NSFontAttributeName: linkFont]
        attStr.addAttributes(linkAttributes, range: range)
      }
      
      attributedParagraph.append(attStr)
    })
    
    return attributedParagraph
  }
}
