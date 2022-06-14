//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import UIKit
import RxSwift
import IQKeyboardManagerSwift
import LifetimeTracker

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appStart: AppStart!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpTrackingMemoryLeaks()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appStart = AppStart(window: window!)
        appStart.start()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }
}


extension AppDelegate {
    private func setUpTrackingMemoryLeaks() {
        LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration(visibility: .visibleWithIssuesDetected,
                                                                            style: .circular).refreshUI)
    }
}
