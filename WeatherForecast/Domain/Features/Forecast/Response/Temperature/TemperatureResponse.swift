//
//  TemperatureResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

struct TemperatureResponse: Decodable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

extension TemperatureResponse {
    func toInfo() -> TemperatureInfo {
        return TemperatureInfo(day: day ?? 0,
                               min: min ?? 0,
                               max: max ?? 0,
                               night: night ?? 0,
                               eve: eve ?? 0,
                               morn: morn ?? 0)
    }
}
