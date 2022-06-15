//
//  WeatherForecastHeader.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation

struct WeatherForecastHeader: Header {
    var requestHeader: [String : String] {
        return headerBuilder
    }
    
    var headerBuilder: [String: String]
}
