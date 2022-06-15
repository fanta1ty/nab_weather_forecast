//
//  WeatherInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class WeatherInfo {
    let id: Double
    let main: WeatherCondition
    let desc: String
    let icon: String
    var iconURL: String
    
    init(id: Double,
         main: WeatherCondition,
         desc: String,
         icon: String,
         iconURL: String) {
        self.id = id
        self.main = main
        self.desc = desc
        self.icon = icon
        self.iconURL = iconURL
    }
    
    init() {
        self.id = 0
        self.main = .clear
        self.desc = ""
        self.icon = ""
        self.iconURL = ""
    }
}
