//
//  ForecastResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

enum ForecastUnit: String {
    case kelvin = "standard", celsius = "metric", fahrenheit = "imperial"
}

extension ForecastUnit {
    var unitText: String {
        switch self {
        case .celsius:
            return "℃"
            
        case .fahrenheit:
            return "℉"
            
        default:
            return "K"
        }
    }
}

struct ForecastResponse: Decodable {
    let city: CityResponse?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [ForecastItemResponse]?
}

extension ForecastResponse {
    func toInfo() -> ForecastInfo {
        return ForecastInfo(city: city?.toInfo() ?? CityInfo(),
                            cod: cod ?? "",
                            message: message ?? 0,
                            cnt: cnt ?? 0,
                            list: list?.map({ $0.toInfo() }) ?? [] )
    }
}
