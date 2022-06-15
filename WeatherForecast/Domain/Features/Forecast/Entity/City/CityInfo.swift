//
//  CityInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class CityInfo {
    let id: Double
    let name: String
    let coord: CityCoordinateInfo
    let country: String
    let population: Double
    let timezone: Double
    
    init(id: Double,
         name: String,
         coord: CityCoordinateInfo,
         country: String,
         population: Double,
         timezone: Double) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.coord = CityCoordinateInfo()
        self.country = ""
        self.population = 0
        self.timezone = 0
    }
}

