import UIKit

public protocol FontBuildable {
    
    associatedtype Builder: FontBuildable
    
    static func builder() -> Builder
    func build() -> UIFont?
    func withFontDescription(_ fontDescription: FontDescription) -> Self
    func scaleWithStyle(_ style: UIFont.TextStyle) -> Self
}

public final class FontBuilder: FontBuildable {
    public typealias Builder = FontBuilder
    
    private var fontDescription: FontDescription?
    private var textStyle: UIFont.TextStyle?
    
    private init() {
    }
    
    public func withFontDescription(_ fontDescription: FontDescription) -> Self {
        self.fontDescription = fontDescription
        return self
    }
    
    public func scaleWithStyle(_ style: UIFont.TextStyle) -> Self {
        self.textStyle = style
        return self
    }
    
    public static func builder() -> FontBuilder {
        return FontBuilder()
    }
    
    public func build() -> UIFont? {
        guard let fontDescription = self.fontDescription,
            let font = UIFont(name: fontDescription.name, size: fontDescription.size)
            else { return UIFont.preferredFont(forTextStyle: textStyle ?? .body) }
        
        if let style = textStyle {
            let fontMetrics = FontMetricsCreator.makeFontMetric(style)
            return fontMetrics.scaledFont(for: font)
        }
        return font
    }
}
