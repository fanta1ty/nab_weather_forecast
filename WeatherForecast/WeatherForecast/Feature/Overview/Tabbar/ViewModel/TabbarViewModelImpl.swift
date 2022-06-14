import Foundation
import RxSwift

final class TabbarViewModelImpl: BaseViewModelImpl {
    let interactor: TabbarInteractable
    
    init(interactor: TabbarInteractable) {
        self.interactor = interactor
        super.init(interactor: interactor)
        
        interactor.onGenericError
            .subscribe(onNext: { _ in
                
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TabbarViewModelImpl: TabbarViewModel {
    var input: DashboardInput {
        return self
    }
    
    var output: DashboardOutput {
        return self
    }
}

extension TabbarViewModelImpl: DashboardInput {
    
}

extension TabbarViewModelImpl: DashboardOutput {
    
}
