import Foundation
import UIKit

extension UIView {
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                           toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                           toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                           toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                           toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func dropShadow(cornerRadius: CGFloat,
                    shadowColor: UIColor,
                    alpha: CGFloat,
                    shadowOffsetHeight: CGFloat) {
        let shadowPath = UIBezierPath(roundedRect: bounds,
                                      cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = shadowColor.withAlphaComponent(alpha).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: shadowOffsetHeight)
        layer.bounds = bounds
        layer.position = center
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addCornerRadius(radius: CGFloat = 6) {
        self.layer.cornerRadius     = radius
        self.layer.masksToBounds    = true
    }
    
    func addBorder(color: UIColor, borderWidth: CGFloat = 1) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }

    var allSubviews: [UIView] {
        return self.subviews.reduce([UIView]()) { $0 + [$1] + $1.allSubviews }
    }

    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }

    func loadFromNib() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self)
    }

    func add(border: ViewBorder, color: UIColor, width: CGFloat) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        borderLayer.name = border.rawValue
        switch border {
        case .left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            borderLayer.frame = CGRect(x: self.frame.size.width - width,
                                       y: 0, width: width,
                                       height: self.frame.size.height)
        case .top:
            borderLayer.frame = CGRect(x: 0, y: 0,
                                       width: self.frame.size.width,
                                       height: width)
        case .bottom:
            borderLayer.frame = CGRect(x: 0,
                                       y: self.frame.size.height - width,
                                       width: self.frame.size.width,
                                       height: width)
        }
        self.layer.addSublayer(borderLayer)
    }

    func remove(border: ViewBorder) {
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers where layer.name == border.rawValue {
            layerForRemove = layer
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
    
    func viewIdentifer() -> String {
        return String(describing: self)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    func addCardViewShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.35).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowRadius = 5
    }

    func removeCardViewShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
    
    func addBackgroundForLoading(area: CGRect, color: UIColor, alpha: Float = 0.5) {
        let backgroundView = UIView(frame: area)
        backgroundView.backgroundColor = color
        backgroundView.alpha = CGFloat(alpha)
        let container = UIView(frame: area)
        container.addSubview(backgroundView)
        self.insertSubview(container, at: 1)
    }
}
