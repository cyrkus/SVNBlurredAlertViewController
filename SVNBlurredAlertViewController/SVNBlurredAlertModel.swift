//
//  SVNBlurredAlertModel.swift
//  SVNBlurredAlertViewController
//
//  Created by Aaron Dean Bikis on 4/7/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import Foundation

public protocol SVNBlurredAlertModel {
    var header: String { get set }
    var body: String { get set }
    var buttonText: String { get set }
}
