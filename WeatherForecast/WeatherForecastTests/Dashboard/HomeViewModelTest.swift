//
//  HomeViewModelTest.swift
//  WeatherForecastTests
//
//  Created by User on 15/06/2022.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
import RxCocoa

@testable import WeatherForecast

class HomeViewModelTest: XCTestCase {
    private let disposeBag = DisposeBag()
    
    private let interator = HomeInteractorMock()
    private var viewModel: HomeViewModelImpl!
    private var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        self.interator.stubbedOnGetForecastError = PublishSubject<String>().asDriver(onErrorJustReturn: "")
        
        self.interator.stubbedOnGenericError = PublishSubject<BaseErrorException>()
        self.interator.stubbedOnNetworkError = PublishSubject<BaseErrorException>()
        self.interator.stubbedSessionTokenExpiredSubject = PublishSubject<BaseErrorException>()
        self.interator.stubbedGetForecastResult = Observable.just(ForecastInfo())
        
        self.viewModel = HomeViewModelImpl(interactor: interator)
        
        self.scheduler = TestScheduler(initialClock: 0)
        scheduler.createHotObservable([.next(0, ())])
            .bind(to: viewModel.baseInput.onViewDidLoad)
            .disposed(by: disposeBag)
    }
}

extension HomeViewModelTest {
    func testViewModelStartSearchForecast() {
        scheduler.createHotObservable([.next(100, "test")])
            .bind(to: viewModel.input.startSearchForecast)
            .disposed(by: disposeBag)
        
        let observer = scheduler.createObserver(ForecastInfo.self)
        
        viewModel.output
            .onForecastResponse
            .drive(observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<ForecastInfo>>] = [
            .next(100, ForecastInfo())
        ]
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
}
