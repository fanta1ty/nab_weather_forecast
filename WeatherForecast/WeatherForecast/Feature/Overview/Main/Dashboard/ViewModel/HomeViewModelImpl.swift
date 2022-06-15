import Foundation
import RxSwift
import RxCocoa

final class HomeViewModelImpl: BaseViewModelImpl {
    private let interactor: HomeInteractable
    private let searchForecastSubject = PublishSubject<String>()
    private var forecastResponseSubject = PublishSubject<ForecastInfo>()

    private var cache = [String: ForecastInfo]()
    
    init(interactor: HomeInteractable) {
        self.interactor = interactor
        super.init(interactor: interactor)
        
        interactor.onGetForecastError
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                
                if let cachedData = self.cache[text] {
                    self.forecastResponseSubject.onNext(cachedData)
                } else {
                    self.forecastResponseSubject.onNext(ForecastInfo())
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textSearch = searchForecastSubject
            .filter { !$0.isEmpty }
            .filter { $0.count >= 3 }
            .flatMap { text -> Observable<ForecastInfo> in
                if let cachedData = self.cache[text] {
                    self.forecastResponseSubject.onNext(cachedData)
                    return Observable.just(cachedData)
                } else {
                    return self.interactor.getForecast(city: text)
                        .do(onNext: { [weak self] data in
                            guard let self = self else { return }
                            self.cache[text] = data
                        })
                }
            }
        
        textSearch.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            
            self.forecastResponseSubject.onNext(data)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: HomeStreamFlow
extension HomeViewModelImpl: HomeViewModel {
    var input: HomeViewModelInput {
        return self
    }
    
    var output: HomeViewModelOutput {
        return self
    }
}

// MARK: HomeInput
extension HomeViewModelImpl: HomeViewModelInput {
    var startSearchForecast: AnyObserver<String> {
        return searchForecastSubject.asObserver()
    }
}

// MARK: HomeOutput
extension HomeViewModelImpl: HomeViewModelOutput {
    var onForecastResponse: Driver<ForecastInfo> {
        let emptyForecast = ForecastInfo()
        return forecastResponseSubject.asDriver(onErrorJustReturn: emptyForecast)
    }
}
