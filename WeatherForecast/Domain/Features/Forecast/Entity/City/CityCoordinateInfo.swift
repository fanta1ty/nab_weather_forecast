//
//  CityCoordinateInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class CityCoordinateInfo {
    let lon: Double
    let lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    init() {
        self.lon = 0
        self.lat = 0
    }
}
