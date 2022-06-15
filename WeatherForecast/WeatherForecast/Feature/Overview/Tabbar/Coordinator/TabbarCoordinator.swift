import Foundation
import UIKit
import RxSwift
import RxCocoa

final class TabbarCoordinator: BaseCoordinator<Void, TabbarDependency> {
    var homeCoordinator: HomeCoordinator?
    let navigationController: UINavigationController
    let homeNavigationController = UINavigationController()
    let viewModel: TabbarViewModel
    
    init(navigationController: UINavigationController, dependency: TabbarDependency) {
        self.navigationController = navigationController
        self.viewModel = dependency.resolve(TabbarViewModel.self)
        super.init(dependency: dependency)
    }
    
    override func getBaseViewModel() -> BaseViewModel? {
        return viewModel
    }
    
    func initHomeCoordinator() {
        let nextDependency = HomeDependency(parent: dependency)
        homeNavigationController.tabBarItem = UITabBarItem()
        
        homeCoordinator = HomeCoordinator(navigationController: homeNavigationController,
                                          dependency: nextDependency)
    }
    
    override func start() -> Driver<Void> {
        let localization = dependency.resolve(Localizable.self)
        let controller = TabbarViewController(viewModel: viewModel, localization: localization)
        
        initHomeCoordinator()
        
        controller.viewControllers = [
            homeNavigationController
        ]
        
        controller.tabBar.tintColor = ProjectColor.mainPrimary.value
        controller.tabBar.unselectedItemTintColor = ProjectColor.gray.value
        
        coordinateToHome()
        
        let window = getUIWindow()!
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        return Driver.never()
    }
    
    private func coordinateToHome() {
        homeCoordinator?.start()
            .drive(onNext: { _ in })
            .disposed(by: disposeBag)
    }
}
