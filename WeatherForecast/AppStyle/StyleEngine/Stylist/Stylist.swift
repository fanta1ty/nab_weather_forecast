import UIKit

public protocol Stylist {
    associatedtype Element
    func style(element: Element)
}

public protocol Stylable {
    func style<T: Stylist>(stylist: T) where T.Element == Self
}

extension Stylable where Self: UIView {
    public func style<T: Stylist>(stylist: T) where Self == T.Element {
        stylist.style(element: self)
    }
}

extension UIView: Stylable {
}
