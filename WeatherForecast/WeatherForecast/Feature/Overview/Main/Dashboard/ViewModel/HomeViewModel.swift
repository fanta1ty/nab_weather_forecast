import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel: BaseViewModel {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

protocol HomeViewModelInput {
    var startSearchForecast: AnyObserver<String> { get }
}

protocol HomeViewModelOutput {
    var onForecastResponse: Driver<ForecastInfo> { get }
}
