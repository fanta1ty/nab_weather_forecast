import Foundation
import RxCocoa
import RxSwift

protocol SplashViewModel: BaseViewModel {
    var input: SplashInput { get }
    var output: SplashOutput { get }
}

protocol SplashInput {
    var startPushToDashboard: AnyObserver<Void> { get }
}

protocol SplashOutput {
    var onPushToDashboard: Driver<Void> { get }
}
