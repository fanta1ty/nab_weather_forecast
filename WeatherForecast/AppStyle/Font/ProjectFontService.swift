import UIKit

public protocol ProjectFontServicing {
     func getFont(style: UIFont.TextStyle) -> UIFont?
    
    func initialize(completion: (() -> Void)?)
}

public class ProjectFontService: ProjectFontServicing {
    
    public static var shared: ProjectFontServicing!
    
    private var fontStyleProvider: FontStyleProvider
    private var fontCollection: FontCollection?
    
    init(fontStyleProvider: FontStyleProvider) {
        self.fontStyleProvider = fontStyleProvider
    }
    
    public func initialize(completion: (() -> Void)?) {
        let descriptions = fontStyleProvider.getFontStyle()
        fontCollection = FontCollection(fontDescriptions: descriptions)
    }
    
    public func getFont(style: UIFont.TextStyle) -> UIFont? {
        return fontCollection?.getFontWithStyle(style)
    }
}
