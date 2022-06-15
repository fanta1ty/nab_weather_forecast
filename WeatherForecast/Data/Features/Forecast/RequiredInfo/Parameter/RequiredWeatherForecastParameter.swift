//
//  RequiredWeatherForecast.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
struct RequiredWeatherForecastParameter {
    let city: String
    let days: Int
    let appId: String
    let unit: ForecastUnit
    
    init(city: String,
         days: Int = 7,
         appId: String = "60c6fbeb4b93ac653c492ba806fc346d",
         unit: ForecastUnit = .celsius) {
        self.city = city
        self.days = days
        self.appId = appId
        self.unit = unit
    }
}

extension RequiredWeatherForecastParameter: RequestParameter {
    var requestParameter: [String: Any] {
        var parameter = [String: Any]()
        
        parameter[RequestField.WeatherForecast.city] = city
        parameter[RequestField.WeatherForecast.days] = days
        parameter[RequestField.WeatherForecast.appId] = appId
        parameter[RequestField.WeatherForecast.unit] = unit.rawValue
        
        return parameter
    }
}
