import UIKit
import RxSwift
import RxCocoa
import LifetimeTracker

protocol BaseViewProtocol {
    var isTheFirstViewFlow: Bool { get set }
}

class BaseViewController<ViewModel>: UIViewController, LifetimeTrackable, BaseViewProtocol {
    var isTheFirstViewFlow: Bool = false
    
    class var lifetimeConfiguration: LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 1, groupName: "VC")
    }
    
    var localization: Localizable!
    var viewModel: ViewModel!
    let disposeBag = DisposeBag()
    
    var timeOutTimer: Timer?
    var customNav: UIView!
    var navigationBarStyle: NavigationBarStyle = .default
    var leftButtonType: NavigationBarButtonType = .none
    var rightButtonType: NavigationBarButtonType = .none
    
    convenience init(viewModel: ViewModel, localization: Localizable) {
        self.init()
        initViewModel(viewModel: viewModel, localization: localization)
    }
    
    deinit {
        Log.v("\(getRawClassName(object: self.classForCoder)) deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    func initViewModel(viewModel: ViewModel, localization: Localizable) {
        self.localization = localization
        self.viewModel = viewModel
        bindGenericException()
        
        bindNetworkErrorException()
        trackLifetime()
        bindLoadingState(viewModel: viewModel)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            Log.v("\(getRawClassName(object: self.classForCoder)) poped from stack")
            guard let viewModel = viewModel as? BaseViewModel else { return }
            viewModel.baseInput.onViewPopedFromStack.onNext(())
        } else {
            Log.v("\(getRawClassName(object: self.classForCoder)) added to stack")
        }
    }
    
    func bindLoadingState(viewModel: ViewModel) {
        guard let viewModel = viewModel as? BaseViewModel else { return }
        
        viewModel.baseOutput
            .onLoadingProgress
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.showLoadingView()
                    
                    self.stopTimeoutTimer()
                    self.startTimoutTimer()
                } else {
                    self.hideLoadingView()
                }
            }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        
        if let animateLoading = keyWindow?.viewWithTag(ViewTags.loadingView) {
            keyWindow?.bringSubviewToFront(animateLoading)
        }
        
        guard let viewModel = viewModel as? BaseViewModel else { return }
        viewModel.baseInput.onViewDidAppear.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        makeUpViews()
        localize()
        extendLayoutToIncludeOpaqueBars()
        
        guard let viewModel = viewModel as? BaseViewModel else { return }
        viewModel.baseInput.onViewDidLoad.onNext(())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Log.v("\(getRawClassName(object: self.classForCoder)) disappeared")
        super.viewDidDisappear(true)
        
        guard let viewModel = viewModel as? BaseViewModel else { return }
        viewModel.baseInput.onViewDidDisappear.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeUpNavigationBar()
        
        NavigationBarManager.onBackClosure = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        NavigationBarManager.onDismissClosure = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        
        bindingData()
        
        guard let viewModel = viewModel as? BaseViewModel else { return }
        viewModel.baseInput.onViewWillAppear.onNext(())
    }
    
    private func makeUpNavigationBar() {
        navigationController?.navigationItem.titleView?.tintColor = ProjectColor.mainPrimary.value
        navigationController?.navigationBar.style(stylist: NavigationBarStylist.primary)
    }
    
    private func extendLayoutToIncludeOpaqueBars() {
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func bindingData() { }
    
    public func bindNetworkErrorException() {
        guard let viewModel = viewModel as? BaseViewModel else { return }
        
        viewModel.baseOutput.onNetworkError
            .drive(onNext: { [weak self] data in
                guard let self = self else { return }
                
                guard let exception = data as? NetworkErrorException else { return }
                
                switch exception.exceptionType {
                default:
                    self.showErrorAlert(title: L10n.General.Alert.ConnectionTimeout.title,
                                        message: L10n.General.Alert.ConnectionTimeout.message,
                                        buttonTitle: L10n.General.Alert.Action.ok) { }
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindGenericException() {
        guard let viewModel = viewModel as? BaseViewModel else { return }
        
        viewModel.baseOutput.onGenericBussinessError
            .drive(onNext: { [weak self] data in
                guard let self = self else { return }
                self.showErrorAlert(title: L10n.General.Alert.GenericError.title,
                                    message: data.errorMessage,
                                    buttonTitle: L10n.General.Alert.Action.ok) { }
            }).disposed(by: disposeBag)
    }
    
    func makeUpViews() { }
    
    func localize() { }
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                            as? NSValue)?.cgRectValue.height ?? 0
                    },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in 0 }
            ]).merge()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        NavigationBarManager.navigationBarStyle = navigationBarStyle
        NavigationBarManager.leftButtonType = leftButtonType
        NavigationBarManager.rightButtonType = rightButtonType
        
        customNav = NavigationBarManager.setupNav()
        view.addSubview(customNav)
    }
    
    @objc private func onStartHideLoadingView() {
        hideLoadingView()
    }
    
    private func stopTimeoutTimer() {
        if timeOutTimer != nil {
            timeOutTimer!.invalidate()
            timeOutTimer = nil
        }
    }
    
    private func startTimoutTimer() {
        if timeOutTimer == nil {
            /// Time out in 3 minutes
            let timeoutInterval = 3 * Double(AppConstants.General.apiCallTimeout)
            timeOutTimer = Timer.scheduledTimer(withTimeInterval: timeoutInterval,
                                                repeats: false, block: { [weak self] _ in
                                                    guard let self = self else { return }
                                                    self.onStartHideLoadingView()
                                                })
        }
    }
    
    func showErrorAlert(title: String,
                        message: String,
                        buttonTitle: String, onButtonHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: .default,
                                      handler: { (_) in
                                        alert.dismiss(animated: true, completion: nil)
                                        onButtonHandler()
                                      }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

func getRawClassName(object: AnyClass) -> String {
    let name = NSStringFromClass(object)
    let components = name.components(separatedBy: ".")
    return components.last ?? "Unknown"
}
