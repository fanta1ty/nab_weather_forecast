//
//  ForecastUseCaseImpl.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ForecastUseCaseImpl: BaseUseCaseImpl<ForecastInfo> {
    private var searchText: String = ""
    private let repository: WeatherForecastRepository
    private let errorResponseSubject = PublishSubject<String>()
    
    init(repository: WeatherForecastRepository) {
        self.repository = repository
    }
    
    override func handleGenericException(with error: Error) {
        errorResponseSubject.onNext(searchText)
    }
}

extension ForecastUseCaseImpl: ForecastUseCase {
    var onErrorResponse: Driver<String> {
        return errorResponseSubject.asDriver(onErrorJustReturn: "")
    }
    
    func buildUseCase(requestBody: RequiredWeatherForecastParameter) -> Self {
        searchText = requestBody.city
        
        mObservable = repository.getWeatherForecast(requestBody: requestBody)
        return self
    }
}
