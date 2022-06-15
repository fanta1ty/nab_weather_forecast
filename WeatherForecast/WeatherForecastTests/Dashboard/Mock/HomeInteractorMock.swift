//
//  HomeInteractorMock.swift
//  WeatherForecastTests
//
//  Created by User on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

@testable import WeatherForecast

class HomeInteractorMock: HomeInteractable {

    var invokedOnGetForecastErrorGetter = false
    var invokedOnGetForecastErrorGetterCount = 0
    var stubbedOnGetForecastError: Driver<String>!

    var onGetForecastError: Driver<String> {
        invokedOnGetForecastErrorGetter = true
        invokedOnGetForecastErrorGetterCount += 1
        return stubbedOnGetForecastError
    }

    var invokedOnGenericErrorGetter = false
    var invokedOnGenericErrorGetterCount = 0
    var stubbedOnGenericError: PublishSubject<BaseErrorException>!

    var onGenericError: PublishSubject<BaseErrorException> {
        invokedOnGenericErrorGetter = true
        invokedOnGenericErrorGetterCount += 1
        return stubbedOnGenericError
    }

    var invokedOnNetworkErrorGetter = false
    var invokedOnNetworkErrorGetterCount = 0
    var stubbedOnNetworkError: PublishSubject<BaseErrorException>!

    var onNetworkError: PublishSubject<BaseErrorException> {
        invokedOnNetworkErrorGetter = true
        invokedOnNetworkErrorGetterCount += 1
        return stubbedOnNetworkError
    }

    var invokedSessionTokenExpiredSubjectGetter = false
    var invokedSessionTokenExpiredSubjectGetterCount = 0
    var stubbedSessionTokenExpiredSubject: PublishSubject<BaseErrorException>!

    var sessionTokenExpiredSubject: PublishSubject<BaseErrorException> {
        invokedSessionTokenExpiredSubjectGetter = true
        invokedSessionTokenExpiredSubjectGetterCount += 1
        return stubbedSessionTokenExpiredSubject
    }

    var invokedGetForecast = false
    var invokedGetForecastCount = 0
    var invokedGetForecastParameters: (city: String, Void)?
    var invokedGetForecastParametersList = [(city: String, Void)]()
    var stubbedGetForecastResult: Observable<ForecastInfo>!

    func getForecast(city: String) -> Observable<ForecastInfo> {
        invokedGetForecast = true
        invokedGetForecastCount += 1
        invokedGetForecastParameters = (city, ())
        invokedGetForecastParametersList.append((city, ()))
        return stubbedGetForecastResult
    }
}
