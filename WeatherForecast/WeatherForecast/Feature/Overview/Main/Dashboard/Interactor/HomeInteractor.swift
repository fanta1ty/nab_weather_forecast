import Foundation
import RxSwift
import RxCocoa

class HomeInteractor: BaseInteractor {
    private let forecastUseCase: ForecastUseCase
    
    private let forecastErrorSubject = PublishSubject<String>()
    
    init(forecastUseCase: ForecastUseCase) {
        self.forecastUseCase = forecastUseCase
        
        super.init(usecases: [forecastUseCase])
        
        forecastUseCase.onErrorResponse.drive(onNext: { [weak self] searchText in
            guard let self = self else { return }
            self.forecastErrorSubject.onNext(searchText)
        })
        .disposed(by: disposeBag)
    }
}

extension HomeInteractor: HomeInteractable {
    var onGetForecastError: Driver<String> {
        return forecastErrorSubject.asDriver(onErrorJustReturn: "")
    }
    
    func getForecast(city: String) -> Observable<ForecastInfo> {
        let requestBody = RequiredWeatherForecastParameter(city: city)
        return forecastUseCase.buildUseCase(requestBody: requestBody)
            .execute()
    }
}
