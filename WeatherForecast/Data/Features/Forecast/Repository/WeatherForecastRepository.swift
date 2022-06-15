//
//  WeatherForecastRepository.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherForecastRepository {
    func getWeatherForecast(requestBody: RequiredWeatherForecastParameter) -> Observable<ForecastInfo>
}
