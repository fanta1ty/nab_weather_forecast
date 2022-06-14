import UIKit
import RxCocoa

final class AppCoordinator: BaseCoordinator<Void, RootDependency> {
    let window: UIWindow
    
    var splashCoordinator: SplashCoordinator?
    var dashboardCoordinator: TabbarCoordinator?
    
    init(window: UIWindow, dependency: RootDependency) {
        self.window = window
        super.init(dependency: dependency)
    }
    
    override func start() -> Driver<Void> {
        let nextDependency = SplashDependency(parent: dependency)
        splashCoordinator = SplashCoordinator(dependency: nextDependency)
        
        splashCoordinator!.start()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigateToDashboard()
                self.splashCoordinator = nil
            })
            .disposed(by: disposeBag)
        
        return Driver.never()
    }
}

// MARK: - Functions
extension AppCoordinator {
    func navigateToDashboard() {
        guard let navavigationController = window.rootViewController as? UINavigationController else { return }
        let nextDependency = TabbarDependency(parent: dependency)
        
        dashboardCoordinator = TabbarCoordinator(navigationController: navavigationController,
                                                 dependency: nextDependency)
        
        dashboardCoordinator!.start().drive(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.dashboardCoordinator = nil
        })
        .disposed(by: disposeBag)
    }
}
