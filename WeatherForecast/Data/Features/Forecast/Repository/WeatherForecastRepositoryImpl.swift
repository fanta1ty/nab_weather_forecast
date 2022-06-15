//
//  WeatherForecastRepositoryImpl.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherForecastRepositoryImpl: BaseRepositoryImpl {
    override init(networking: Networking) {
        super.init(networking: networking)
    }
}

extension WeatherForecastRepositoryImpl: WeatherForecastRepository {
    func getWeatherForecast(requestBody: RequiredWeatherForecastParameter) -> Observable<ForecastInfo> {
        return self.getWeatherForecast(requestBody: requestBody)
            .map { $0.toInfo() }
    }
}

extension WeatherForecastRepositoryImpl {
    private func getWeatherForecast(requestBody: RequiredWeatherForecastParameter) -> Observable<ForecastResponse> {
        let path = UrlConstant.Forecast.daily
        let jsonDecoder = JSONDecoder()
        let parser = JsonParser<ForecastResponse>(jsonDecoder: jsonDecoder)
        let header = WeatherForecastHeader(headerBuilder: requestHeaderBuilder())
        
        return networking.get(path: path,
                              parameters: requestBody,
                              encoder: .url,
                              headers: header,
                              parser: parser)
    }
}
