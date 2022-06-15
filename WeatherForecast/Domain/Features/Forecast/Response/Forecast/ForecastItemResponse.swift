//
//  ForecastItemResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

struct ForecastItemResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, feelsLike = "feels_like", pressure, humidity, weather, speed, deg, clouds, pop
    }
    
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: TemperatureResponse?
    let feelsLike: FeelsLikeResponse?
    let pressure: Double?
    let humidity: Double?
    let weather: [WeatherResponse]?
    let speed: Double?
    let deg: Double?
    let clouds: Double?
    let pop: Double?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = try values.decodeIfPresent(Double.self, forKey: .dt)
        self.sunrise = try values.decodeIfPresent(Double.self, forKey: .sunrise)
        self.sunset = try values.decodeIfPresent(Double.self, forKey: .sunset)
        self.temp = try values.decodeIfPresent(TemperatureResponse.self, forKey: .temp)
        self.feelsLike = try values.decodeIfPresent(FeelsLikeResponse.self, forKey: .feelsLike)
        self.pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        self.humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        self.weather = try values.decodeIfPresent([WeatherResponse].self, forKey: .weather)
        self.speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        self.deg = try values.decodeIfPresent(Double.self, forKey: .deg)
        self.clouds = try values.decodeIfPresent(Double.self, forKey: .clouds)
        self.pop = try values.decodeIfPresent(Double.self, forKey: .pop)
    }
}

extension ForecastItemResponse {
    func toInfo() -> ForecastItemInfo {
        return ForecastItemInfo(dt: dt ?? 0,
                                sunrise: sunrise ?? 0,
                                sunset: sunset ?? 0,
                                temp: temp?.toInfo() ?? TemperatureInfo(),
                                feelsLike: feelsLike?.toInfo() ?? FeelsLikeInfo(),
                                pressure: pressure ?? 0,
                                humidity: humidity ?? 0,
                                weather: weather?.map({ $0.toInfo() }) ?? [],
                                speed: speed ?? 0,
                                deg: deg ?? 0,
                                clouds: clouds ?? 0,
                                pop: pop ?? 0)
    }
}
