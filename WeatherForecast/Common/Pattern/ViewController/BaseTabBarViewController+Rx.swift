import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITabBarController {
    public var onViewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var onViewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var onViewDidAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
    
    public var onViewDidDisappear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
