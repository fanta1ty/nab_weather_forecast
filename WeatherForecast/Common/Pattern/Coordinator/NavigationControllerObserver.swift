import UIKit

public class NavigationControllerObserver: NSObject {
    
    private let navigationController: UINavigationController
    private var viewControllersToDelegates: [UIViewController: NavigationControllerObserverDelegateContainer] = [:]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }
    
    public func observePopTransition(of viewController: UIViewController,
                                     delegate: NavigationControllerObserverDelegate) {
        let wrappedDelegate = NavigationControllerObserverDelegateContainer(value: delegate)
        viewControllersToDelegates[viewController] = wrappedDelegate
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationControllerObserver: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }
        
        if let wrappedDelegate = viewControllersToDelegates[fromViewController] {
            let delegate = wrappedDelegate.value
            delegate?.navigationControllerObserver(self, didObservePopTransitionFor: fromViewController)
            viewControllersToDelegates.removeValue(forKey: fromViewController)
        }
    }
}

public protocol NavigationControllerObserverDelegate: AnyObject {
    func navigationControllerObserver(_ observer: NavigationControllerObserver,
                                      didObservePopTransitionFor viewController: UIViewController)
}

// We can't use Weak here because we would have
// to declare NavigationControllerObserverDelegate as @objc
private class NavigationControllerObserverDelegateContainer {
    
    private(set) weak var value: NavigationControllerObserverDelegate?
    
    init(value: NavigationControllerObserverDelegate) {
        self.value = value
    }
}
