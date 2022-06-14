//
//  URL+Ext.swift
//  ExampleConcept
//
//  Created by Thinh Nguyen on 11/2/21.
//

import Foundation
import UIKit

extension URL {
    var queryDictionary: [String: Any]? {
        guard let query = query else { return nil }

        var queryStrings = [String: Any]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy: "=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        
        return queryStrings
    }
}
