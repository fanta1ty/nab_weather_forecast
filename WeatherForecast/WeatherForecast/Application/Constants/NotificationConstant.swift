//
//  NotificationConstant.swift
//  ExampleConcept
//
//  Created by Dat Huynh on 13/07/2021.
//
import UIKit

extension Notification.Name {
    static let updateBadgeCartNumber = Notification.Name("updateBadgeCartNumber")
    
    static let getProfile = Notification.Name("getProfile")
    static let refreshProfile = Notification.Name("refreshProfile")
    
    static let getCartList = Notification.Name("getCartList")
    static let refreshCartList = Notification.Name("refreshCartList")
    
    static let getAddresses = Notification.Name("getAddresses")
    static let refreshAddresses = Notification.Name("refreshAddresses")
}
