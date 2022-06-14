//
//  SceneDelegate.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appStart: AppStart!
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene  = windowScene
        appStart = AppStart(window: window!)
        appStart.start()
    }
}

