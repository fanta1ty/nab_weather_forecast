import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {
    var baseInput: BaseViewModelInput { get }
    var baseOutput: BaseViewModelOutput { get }
}

protocol BaseViewModelInput {
    var onViewDidLoad: AnyObserver<Void> { get }
    var onViewWillAppear: AnyObserver<Void> { get }
    var onViewDidAppear: AnyObserver<Void> { get }
    var onViewDidDisappear: AnyObserver<Void> { get }
    var onViewPopedFromStack: AnyObserver<Void> { get }
}

protocol BaseViewModelOutput {
    var onGenericBussinessError: Driver<BaseErrorException> { get }
    var onNetworkError: Driver<BaseErrorException> { get }
    var onSessionTokenExpired: Driver<BaseErrorException> { get }
    var onUpdateWhenViewPopedFromStack: Driver<Void> { get }
    var onLoadingProgress: Driver<Bool> { get }
}

class BaseViewModelImpl {
    let onGenericBussinessErrorSubject = PublishSubject<BaseErrorException>()
    let onNetworkErrorSubject = PublishSubject<BaseErrorException>()
    let onSessionTokenExpiredSubject = PublishSubject<BaseErrorException>()
    let onViewPopedFromStackSubject = PublishSubject<Void>()
    
    private let baseInteractor: BaseInteractable?

    let isLoadingSubject = PublishSubject<Bool>()
    let onViewWillAppearSubject = PublishSubject<Void>()
    let onViewDidLoadSubject = PublishSubject<Void>()
    let onViewDidAppearSubject = PublishSubject<Void>()
    let onViewDidDisappearSubject = PublishSubject<Void>()

    let disposeBag = DisposeBag()

    deinit {
        Log.v("\(String(describing: type(of: self))) deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    init(interactor: BaseInteractable?) {
        self.baseInteractor = interactor
        self.handleGenericException()
        self.handleNetworkException()
        
        onViewWillAppearSubject.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewWillAppear()
        }).disposed(by: disposeBag)
        
        onViewDidLoadSubject.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewDidLoad()
        }).disposed(by: disposeBag)
        
        onViewDidAppearSubject.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewDidAppear()
        }).disposed(by: disposeBag)
        
        onViewDidDisappearSubject.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            self.viewDidDisappear()
        }).disposed(by: disposeBag)
    }

    func viewDidLoad() { }

    func viewWillAppear() { }

    func viewDidAppear() { }

    func viewDidDisappear() { }

    func handleGenericException() {
        guard let interactor = baseInteractor else { return }
        interactor.onGenericError
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                self.isLoadingSubject.onNext(false)
                self.onGenericBussinessErrorSubject.onNext(data)
                
            })
            .disposed(by: disposeBag)
    }

    func handleNetworkException() {
        if let interactor = baseInteractor {
            interactor.onNetworkError
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    
                    self.isLoadingSubject.onNext(false)
                    self.onNetworkErrorSubject.onNext(data)
                })
                .disposed(by: disposeBag)

            interactor.sessionTokenExpiredSubject
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    self.isLoadingSubject.onNext(false)
                    
                    self.onSessionTokenExpiredSubject.onNext(data)
                })
                .disposed(by: disposeBag)
        }
    }
}

extension BaseViewModelImpl: BaseViewModel {
    var baseInput: BaseViewModelInput {
        return self
    }

    var baseOutput: BaseViewModelOutput {
        return self
    }
}

extension BaseViewModelImpl: BaseViewModelInput {
    var onViewPopedFromStack: AnyObserver<Void> {
        return onViewPopedFromStackSubject
            .asObserver()
    }
    
    var onViewWillAppear: AnyObserver<Void> {
        return onViewWillAppearSubject
            .asObserver()
    }
    
    var onViewDidLoad: AnyObserver<Void> {
        return onViewDidLoadSubject
            .asObserver()
    }
    
    var onViewDidAppear: AnyObserver<Void> {
        return onViewDidAppearSubject
            .asObserver()
    }
    
    var onViewDidDisappear: AnyObserver<Void> {
        return onViewDidDisappearSubject
            .asObserver()
    }
}

extension BaseViewModelImpl: BaseViewModelOutput {
    var onUpdateWhenViewPopedFromStack: Driver<Void> {
        return onViewPopedFromStackSubject
            .asDriver(onErrorJustReturn: ())
    }
    
    var onSessionTokenExpired: Driver<BaseErrorException> {
        return onSessionTokenExpiredSubject
            .asDriver(onErrorJustReturn: BaseErrorException())
    }
    
    var onGenericBussinessError: Driver<BaseErrorException> {
        return onGenericBussinessErrorSubject
            .asDriver(onErrorJustReturn: BaseErrorException())
    }

    var onNetworkError: Driver<BaseErrorException> {
        return onNetworkErrorSubject
            .asDriver(onErrorJustReturn: BaseErrorException())
    }

    var onLoadingProgress: Driver<Bool> {
        return isLoadingSubject
            .asDriver(onErrorJustReturn: false)
    }
}
