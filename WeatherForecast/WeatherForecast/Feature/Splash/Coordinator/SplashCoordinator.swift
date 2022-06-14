import UIKit
import RxCocoa
import RxSwift

final class SplashCoordinator: BaseCoordinator<Void, SplashDependency> {
    private let viewModel: SplashViewModel
    private let localization: Localizable
    private let controller: SplashViewController
    private let result = PublishSubject<Void>()
    
    override init(dependency: SplashDependency) {
        self.viewModel = dependency.resolve(SplashViewModel.self)
        self.localization = dependency.resolve(Localizable.self)
        self.controller = SplashViewController(viewModel: self.viewModel,
                                               localization: self.localization)
        self.controller.navigationBarStyle = .none
        super.init(dependency: dependency)
    }
    
    override func getBaseViewModel() -> BaseViewModel? {
        return viewModel
    }
    
    override func start() -> Driver<Void> {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let window = getUIWindow()!
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return result.asDriver(onErrorJustReturn: ())
    }
    
    override func viewModelBinding() {
        super.viewModelBinding()
        
        viewModel.output
            .onPushToDashboard
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.result.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
