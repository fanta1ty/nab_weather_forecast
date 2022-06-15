//
//  FeelsLikeInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class FeelsLikeInfo {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    init(day: Double, night: Double, eve: Double, morn: Double) {
        self.day = day
        self.night = night
        self.eve = eve
        self.morn = morn
    }
    
    init() {
        self.day = 0
        self.night = 0
        self.eve = 0
        self.morn = 0
    }
}
