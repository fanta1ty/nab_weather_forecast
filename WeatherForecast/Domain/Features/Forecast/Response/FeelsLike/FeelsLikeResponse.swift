//
//  FeelsLikeResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

struct FeelsLikeResponse: Decodable {
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

extension FeelsLikeResponse {
    func toInfo() -> FeelsLikeInfo {
        return FeelsLikeInfo(day: day ?? 0,
                             night: night ?? 0,
                             eve: eve ?? 0,
                             morn: morn ?? 0)
    }
}
