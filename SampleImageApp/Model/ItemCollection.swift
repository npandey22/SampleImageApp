//
//  ItemCollection.swift
//  SampleImageApp
//
//  Created by Neha Pandey on 22/06/19.
//  Copyright © 2019 Neha Pandey. All rights reserved.
//

import UIKit
struct ItemCollection {
    // MARK: - Properties
    var headerTitle: String?
    var row: [[String: Any]]?
    static var sharedInstance = ItemCollection()
    private init() {}
}

