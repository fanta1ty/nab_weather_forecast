import Foundation
import UIKit

final class SearchBarTextField: UITextField {
    /// This holds the configured raster size, which is important for rect calculation.
    var config: SearchBarConfig {
        didSet {
            setNeedsLayout()
        }
    }

    init(config: SearchBarConfig) {
        self.config = config
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rectForBounds(rect, originalBounds: bounds)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rectForBounds(rect, originalBounds: bounds)
    }
}

extension SearchBarTextField {
    /// Calculates the text bounds depending on the visibility of left and right views.
    func rectForBounds(_ bounds: CGRect, originalBounds: CGRect) -> CGRect {
        var minX: CGFloat = 0
        var width: CGFloat = 0

        if bounds.width == originalBounds.width {
            // no left and no right view
            minX = config.rasterSize
            width = bounds.width - config.rasterSize * 2

        } else if bounds.minX > 0 && bounds.width == originalBounds.width - bounds.minX {
            // only left view
            minX = bounds.minX
            width = bounds.width - config.rasterSize

        } else if bounds.minX == 0 && bounds.width < originalBounds.width {
            // only right view
            minX = config.rasterSize
            width = bounds.width - config.rasterSize

        } else {
            // left & right view
            minX = bounds.minX
            width = bounds.width
        }
        return CGRect(x: minX, y: 0.0, width: width, height: bounds.height)
    }
}
