import UIKit

public protocol FontMetrics {
    
    func scaledFont(for font: UIFont) -> UIFont

    func scaledFont(for font: UIFont, maximumPointSize: CGFloat) -> UIFont
    
    func scaledValue(for value: CGFloat) -> CGFloat
}

public class FontMetricsCreator {
    public static func makeFontMetric(_ style: UIFont.TextStyle) -> FontMetrics {
        if #available(iOS 11.0, *) {
            return style.metrics
        } else {
            return FontMetricsUnderOs11()
        }
    }
}

@available(iOS 11.0, *)
extension UIFontMetrics: FontMetrics {
    
}

public struct FontMetricsUnderOs11: FontMetrics {

    /// A scale value based on the current device text size setting. With the device using the
    /// default Large setting, `scaler` will be `1.0`. Only used when `UIFontMetrics` is not
    /// available.
    ///
    var scaler: CGFloat {
        return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
    }

    /// Returns a version of the specified font that adopts the current font metrics.
    ///
    /// - Parameter font: A font at its default point size.
    /// - Returns: The font at its scaled point size.
    ///
    public func scaledFont(for font: UIFont) -> UIFont {
        return font.withSize(scaler * font.pointSize)
    }

    /// Returns a version of the specified font that adopts the current font metrics and is
    /// constrained to the specified maximum size.
    ///
    /// - Parameters:
    ///   - font: A font at its default point size.
    ///   - maximumPointSize: The maximum point size to scale up to.
    /// - Returns: The font at its constrained scaled point size.
    ///
    public func scaledFont(for font: UIFont, maximumPointSize: CGFloat) -> UIFont {
         return font.withSize(min(scaler * font.pointSize, maximumPointSize))
    }

    /// Scales an arbitrary layout value based on the current Dynamic Type settings.
    ///
    /// - Parameter value: A default size value.
    /// - Returns: The value scaled based on current Dynamic Type settings.
    ///
    public func scaledValue(for value: CGFloat) -> CGFloat {
        return scaler * value
    }
}
