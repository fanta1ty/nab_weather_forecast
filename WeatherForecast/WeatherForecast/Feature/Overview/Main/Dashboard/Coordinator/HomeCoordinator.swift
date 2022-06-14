import UIKit
import RxCocoa
import RxSwift

final class HomeCoordinator: BaseCoordinator<Bool, HomeDependency> {
    let navigationController: UINavigationController
    let viewModel: HomeViewModel
    let localization: Localizable
    let result = PublishSubject<Bool>()
    let controller: MainViewController
    
    init(navigationController: UINavigationController,
         dependency: HomeDependency) {
        self.navigationController = navigationController
        self.viewModel = dependency.resolve(HomeViewModel.self)
        self.localization = dependency.resolve(Localizable.self)
        self.controller = MainViewController(viewModel: self.viewModel,
                                             localization: self.localization)
        self.controller.navigationBarStyle = .main
        super.init(dependency: dependency)
    }
    
    override func getBaseViewModel() -> BaseViewModel? {
        return viewModel
    }
    
    override func start() -> Driver<Bool> {
        navigationController.setViewControllers([controller], animated: false)
        return result.asDriver(onErrorJustReturn: false)
    }
    
    override func viewModelBinding() {
        super.viewModelBinding()
    }
}
