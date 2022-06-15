//
//  TemperatureInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class TemperatureInfo {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    init(day: Double,
         min: Double,
         max: Double,
         night: Double,
         eve: Double,
         morn: Double) {
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
    
    init() {
        self.day = 0
        self.min = 0
        self.max = 0
        self.night = 0
        self.eve = 0
        self.morn = 0
    }
}
