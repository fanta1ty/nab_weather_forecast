import Foundation
import RxSwift

protocol BaseInteractable {
    var onGenericError: PublishSubject<BaseErrorException> { get }
    var onNetworkError: PublishSubject<BaseErrorException> { get }
    var sessionTokenExpiredSubject: PublishSubject<BaseErrorException> { get }
}

class BaseInteractor: BaseInteractable {
    let disposeBag = DisposeBag()
    
    let onGenericError = PublishSubject<BaseErrorException>()
    let onNetworkError = PublishSubject<BaseErrorException>()
    let sessionTokenExpiredSubject = PublishSubject<BaseErrorException>()
    private var usecases = [BaseUseCase]()
    
    init(usecases: [BaseUseCase]) {
        self.usecases = usecases
        bindGenericException()
    }
    
    func bindGenericException() {
        for usecase in usecases {
            usecase.generalErrorSubject
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    self.onGenericError.onNext(data)
                })
                .disposed(by: disposeBag)
            
            usecase.networkErrorSubject.subscribe(onNext: { [weak self](exception) in
                self?.onNetworkError.onNext(exception)
            }, onError: { (error) in
                Log.e(error)
            })
            .disposed(by: disposeBag)
            
            usecase.sessionTokenExpiredSubject.subscribe(onNext: { [weak self](exception) in
                self?.sessionTokenExpiredSubject.onNext(exception)
            }, onError: { (error) in
                Log.e(error)
            })
            .disposed(by: disposeBag)
        }
    }
}
