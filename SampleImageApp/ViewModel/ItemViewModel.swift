//
//  ItemViewModel.swift
//  SampleImageApp
//
//  Created by Neha Pandey on 22/06/19.
//  Copyright © 2019 Neha Pandey. All rights reserved.
//

import Foundation
class ItemViewModel {
    // MARK: - Closures for callback
    var completionHandler: (() -> ())?
    var showAlertClosure: (() -> ())?
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    // MARK: - API to retrieve data
    func FetchResources() {
        // MARK: - Network Call
        NetworkConnectivity.shared.requestFetchResources() { (result) in
            switch result {
            case .success(let response):
                if let responseDictionary = response as? [String: Any] {
                    if let ImageDataDictionary = responseDictionary["rows"] as? [[String: Any]] {
                        let imgResponseDict = ImageDataDictionary.filter { !($0["title"] as? String == nil && $0["description"] as? String == nil && $0["imageHref"] as? String == nil)}
                        ItemCollection.sharedInstance.row = imgResponseDict
                    }
                    if let title = responseDictionary["title"] as? String {
                        ItemCollection.sharedInstance.headerTitle = title
                    }
                }
                // MARK: - Callback for Success
                self.completionHandler?()
            case .failure(let error):
                // MARK: - Callback for Failure
                self.error = error
            }
        }
    }
}
