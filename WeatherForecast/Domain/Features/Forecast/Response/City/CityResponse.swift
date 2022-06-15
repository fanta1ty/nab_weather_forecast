//
//  CityResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

struct CityResponse: Decodable {
    let id: Double?
    let name: String?
    let coord: CityCoordinateResponse?
    let country: String?
    let population: Double?
    let timezone: Double?
}

extension CityResponse {
    func toInfo() -> CityInfo {
        return CityInfo(id: id ?? 0,
                        name: name ?? "",
                        coord: coord?.toInfo() ?? CityCoordinateInfo(),
                        country: country ?? "",
                        population: population ?? 0,
                        timezone: timezone ?? 0)
    }
}
