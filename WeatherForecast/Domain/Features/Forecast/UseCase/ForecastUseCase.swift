//
//  ForecastUseCase.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ForecastUseCase: BaseUseCase {
    var onErrorResponse: Driver<String> { get }
    
    func execute() -> Observable<ForecastInfo>
    func buildUseCase(requestBody: RequiredWeatherForecastParameter) -> Self
}
