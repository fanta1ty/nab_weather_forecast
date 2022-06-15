import Foundation
import RxSwift
import RxCocoa

class BaseCoordinator<CoordinatorResult, T: Dependency>: NSObject, Coordinator {
    typealias ResultType = CoordinatorResult

    var identifier = UUID()
    var disposeBag = DisposeBag()
    var dependency: T

    private var childCoordinators = [UUID: Any]()

    init(dependency: T) {

        self.dependency = dependency
        super.init()
        viewModelBinding()
    }
    
    deinit {
        Log.v("\(getRawClassName(object: self.classForCoder)) deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    private func store<C: Coordinator>(coordinator: C) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release<C: Coordinator>(coordinator: C) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }

    func start() -> Driver<CoordinatorResult> {
        fatalError("This method must be overridden")
    }

    func getBaseViewModel() -> BaseViewModel? {
        fatalError("This method getBaseViewModel() must be overridden in child class")
    }
    
    func viewModelBinding() { }

    func getRawClassName(object: AnyClass) -> String {
        let name = NSStringFromClass(object)
        let components = name.components(separatedBy: ".")
        return components.last ?? "Unknown"
    }
}
