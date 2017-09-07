//
//  CoordViewController.swift
//  LendWallet
//
//  Created by Aaron Dean Bikis on 6/14/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit

open class CoordinatableViewController: UIViewController {
  
  public init(){
    super.init(nibName: nil, bundle: nil)
  }
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init:coder is not supported by Viewcontrollers presented by Coordinators")
  }
  
  deinit {
    print("\(String(describing: self)) deinit")
  }
  
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
}
