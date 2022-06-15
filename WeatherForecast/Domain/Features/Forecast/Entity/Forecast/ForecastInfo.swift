//
//  ForecastInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class ForecastInfo {
    let city: CityInfo
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ForecastItemInfo]
    
    init(city: CityInfo, cod: String, message: Double, cnt: Int, list: [ForecastItemInfo]) {
        self.city = city
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
    }
    
    init() {
        self.city = CityInfo()
        self.cod = ""
        self.message = 0
        self.cnt = 0
        self.list = []
    }
}

// MARK: - Equatable
extension ForecastInfo: Equatable {
    static func == (lhs: ForecastInfo, rhs: ForecastInfo) -> Bool {
        return lhs.city == rhs.city &&
        lhs.cod == rhs.cod &&
        lhs.message == rhs.message &&
        lhs.cnt == rhs.cnt &&
        lhs.list.count == rhs.list.count
    }
}
