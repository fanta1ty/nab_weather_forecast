import UIKit
import RxSwift

final class AppStart {
    let window: UIWindow
    var appCoordinator: AppCoordinator?
    var disposeBag = DisposeBag()
    var rootDependency: RootDependency
    var appStyle: ProjectStyle?
    
    init(window: UIWindow) {
        self.window = window
        rootDependency = RootDependency()
    }
    
    func start() {
        appStyle = rootDependency.resolver.resolve(ProjectStyle.self)
        appStyle?.initialize()
       
        appCoordinator = AppCoordinator(window: window, dependency: rootDependency)
        appCoordinator?.start()
            .drive()
            .disposed(by: disposeBag)
    }
}
