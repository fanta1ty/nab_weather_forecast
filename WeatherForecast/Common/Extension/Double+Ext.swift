//
//  Double+Ext.swift
//  ExampleConcept
//
//  Created by Thinh Nguyen on 8/21/21.
//

import Foundation
import UIKit

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
}
