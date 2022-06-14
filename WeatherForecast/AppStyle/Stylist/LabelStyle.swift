import Foundation
import UIKit

public struct LabelStyle {
    
    var textColor: ProjectColor
    var textFont: ProjectFont
    var alignment: NSTextAlignment
    
    init(textColor: ProjectColor,
         textFont: ProjectFont,
         alignment: NSTextAlignment = .left) {
        self.textColor = textColor
        self.textFont = textFont
        self.alignment = alignment
    }
}
