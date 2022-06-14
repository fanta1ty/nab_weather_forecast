import UIKit

public class FontCollection {
    private var fontCollection = [String: FontDescription]()
    
    public init(fontDescriptions: [FontDescription]) {
        fontDescriptions.forEach { description in
            fontCollection[description.style] = description
        }
    }
    
    public func getFontWithStyle(_ style: UIFont.TextStyle) -> UIFont? {
        guard let fontDescription = fontCollection[style.rawValue] else {
            return FontBuilder.builder().build()
        }
        
        return FontBuilder
            .builder()
            .withFontDescription(fontDescription)
            .scaleWithStyle(style)
            .build()
    }
}
