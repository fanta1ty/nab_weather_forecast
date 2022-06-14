import Foundation
import UIKit

enum NavigationBarButtonType {
    case none, back, close, cancel
}

enum NavigationBarStyle {
    case none, main, `default`
}

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length
final class NavigationBarManager {
    static let shared = NavigationBarManager()
    static var navigationBarStyle: NavigationBarStyle = .default {
        didSet {
            switch navigationBarStyle {
            case .main:
                height = topPadding + 98

            case .none:
                height = 0
                
            default:
                height = topPadding + 44
            }
            
            bottomConstraint = height - topPadding
        }
    }
    static var leftButtonType: NavigationBarButtonType!
    static var rightButtonType: NavigationBarButtonType!

    static var onBackClosure: (() -> Void)?
    static var onDismissClosure: (() -> Void)?

    static let topPadding = UIApplication.shared.windows
        .filter { $0.isKeyWindow }
        .first?.safeAreaInsets.top ?? 0
    
    static var bottomConstraint: CGFloat = 44
    
    static var height: CGFloat = 44
}

extension NavigationBarManager {
    static func setupNav() -> UIView {
        let navigationFrame = CGRect(x: 0, y: 0,
                                     width: UIScreen.main.bounds.width,
                                     height: height)
        switch navigationBarStyle {
        case .main:
            return NMainView(frame: navigationFrame)

        case .none:
            return UIView(frame: .zero)

        default:
            let navView = NDefaultView(frame: navigationFrame)
            navView.leftButtonType = leftButtonType
            navView.rightButtonType = rightButtonType
            
            navView.onActionClosure = {
                switch navView.leftButtonType {
                case .back:
                    onBackClosure?()

                case .close:
                    onDismissClosure?()

                default:
                    break
                }
            }
            
            navView.onRightActionClosure = {
                switch navView.rightButtonType {
                case .cancel:
                    onDismissClosure?()
                    
                default:
                    break
                }
            }
            return navView
        }
    }
}
