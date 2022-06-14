import Foundation
import RxSwift
import RxCocoa

final class HomeViewModelImpl: BaseViewModelImpl {
    private let interactor: HomeInteractable

    init(interactor: HomeInteractable) {
        self.interactor = interactor
        super.init(interactor: interactor)
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
}

// MARK: HomeOutput
extension HomeViewModelImpl: HomeViewModelOutput {
}
