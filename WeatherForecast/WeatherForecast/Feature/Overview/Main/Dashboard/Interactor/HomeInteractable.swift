import Foundation
import RxSwift
import RxCocoa

protocol HomeInteractable: BaseInteractable {
    var onGetForecastError: Driver<String> { get }
    func getForecast(city: String) -> Observable<ForecastInfo>
}
