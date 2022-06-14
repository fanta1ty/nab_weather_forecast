//
//  Character+Ext.swift
//  ExampleConcept
//
//  Created by Thinh Nguyen on 8/28/21.
//

import Foundation
import UIKit

extension Character {
    func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self
            && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self
            && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
}
