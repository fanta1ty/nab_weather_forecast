import UIKit

enum BackgroundStylist {
    case main
}

// MARK: Stylist
extension BackgroundStylist: Stylist {
    typealias Element = UIView
    
    func style(element: UIView) {
    }
}
