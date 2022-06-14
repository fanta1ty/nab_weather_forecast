import Foundation
import RxSwift
import RxCocoa

final class SplashViewModelImpl: BaseViewModelImpl {
    private let interactor: SplashInteractable
    
    private let pushToDashboardSubject = PublishSubject<Void>()
    
    init(interactor: SplashInteractable) {
        self.interactor = interactor
        super.init(interactor: interactor)
    }
}

// MARK: SplashStreamFlow
extension SplashViewModelImpl: SplashViewModel {
    var input: SplashInput {
        return self
    }
    
    var output: SplashOutput {
        return self
    }
}

// MARK: SplashInput
extension SplashViewModelImpl: SplashInput {
    var startPushToDashboard: AnyObserver<Void> {
        return pushToDashboardSubject.asObserver()
    }
}

// MARK: SplashOutput
extension SplashViewModelImpl: SplashOutput {
    var onPushToDashboard: Driver<Void> {
        return pushToDashboardSubject.asDriver(onErrorJustReturn: ())
    }
}
