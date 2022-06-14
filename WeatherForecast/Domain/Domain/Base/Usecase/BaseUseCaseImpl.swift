import Foundation
import RxSwift
import RxCocoa

protocol BaseUseCase {
    var networkErrorSubject: PublishSubject<NetworkErrorException> { get }
    var technicalErrorSubject: PublishSubject<TechnicalErrorException> { get }
    var sessionTokenExpiredSubject: PublishSubject<UnauthorizedErrorException> { get }
    var generalErrorSubject: PublishSubject<BaseErrorException> { get }
}
class BaseUseCaseImpl<T> {
    let disposeBag = DisposeBag()
    var networkErrorSubject = PublishSubject<NetworkErrorException>()
    var technicalErrorSubject = PublishSubject<TechnicalErrorException>()
    var sessionTokenExpiredSubject = PublishSubject<UnauthorizedErrorException>()
    var generalErrorSubject = PublishSubject<BaseErrorException>()
    
    var mDisposable: Disposable?
    var mObservable: Observable<T>?
    let requestTimeoutInSecond = 45
    var responseObservable = PublishSubject<T>()
    
    func execute() -> Observable<T> {
        responseObservable = PublishSubject<T>()
        mDisposable?.dispose()
        mDisposable = mObservable!
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](info) in
                self?.responseObservable.onNext(info)
            }, onError: { [weak self] (error) in
                Log.e(error)
                self?.handleAllExceptions(error: error)
            })
        
        return responseObservable.asObservable()
    }
    public func handleAllExceptions(error: Error) {
        if let error = error as? NetworkErrorException {
            networkErrorSubject.onNext(error)
            return
        }
        if let error = error as? UnauthorizedErrorException {
            sessionTokenExpiredSubject.onNext(error)
            return
        }
        handleGenericException(with: error)
    }

    public func handleGenericException(with error: Error) {
        if let baseException = error as? BaseErrorException {
            Log.d("========== error code ============ \(baseException.errorCode)")
            Log.d("========== error message ============ \(baseException.errorMessage)")
            generalErrorSubject.onNext(baseException)
        } else {
            generalErrorSubject.onNext(BaseErrorException(errorCode: "-1", errorMessage: "unknown"))
        }
    }
}
