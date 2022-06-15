//
//  ForecastItemInfo.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

class ForecastItemInfo {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: TemperatureInfo
    let feelsLike: FeelsLikeInfo
    let pressure: Double
    let humidity: Double
    let weather: [WeatherInfo]
    let speed: Double?
    let deg: Double?
    let clouds: Double?
    let pop: Double?
    
    init(dt: Double,
         sunrise: Double,
         sunset: Double,
         temp: TemperatureInfo,
         feelsLike: FeelsLikeInfo,
         pressure: Double,
         humidity: Double,
         weather: [WeatherInfo],
         speed: Double,
         deg: Double,
         clouds: Double,
         pop: Double) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.weather = weather
        self.speed = speed
        self.deg = deg
        self.clouds = clouds
        self.pop = pop
    }
    
    init() {
        self.dt = 0
        self.sunrise = 0
        self.sunset = 0
        self.temp = TemperatureInfo()
        self.feelsLike = FeelsLikeInfo()
        self.pressure = 0
        self.humidity = 0
        self.weather = []
        self.speed = 0
        self.deg = 0
        self.clouds = 0
        self.pop = 0
    }
}
