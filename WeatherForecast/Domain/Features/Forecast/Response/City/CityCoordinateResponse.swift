//
//  CityCoordinateResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

struct CityCoordinateResponse: Decodable {
    let lon: Double?
    let lat: Double?
}

extension CityCoordinateResponse {
    func toInfo() -> CityCoordinateInfo {
        return CityCoordinateInfo(lon: lon ?? 0,
                                  lat: lat ?? 0)
    }
}
