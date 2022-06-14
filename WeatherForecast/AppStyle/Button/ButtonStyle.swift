import Foundation
import UIKit

public struct ButtonStyle {
    var backGroundColor: ProjectColor
    var borderColor: ProjectColor
    var borderWidth: CGFloat
    var borderRadius: CGFloat
    var textColor: ProjectColor
    var textFont: ProjectFont

    init(backGroundColor: ProjectColor = .clear,
         borderColor: ProjectColor = .clear,
         borderWidth: CGFloat = 0,
         borderRadius: CGFloat = 0,
         textColor: ProjectColor,
         textFont: ProjectFont) {
        self.backGroundColor = backGroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.borderRadius = borderRadius
        self.textColor = textColor
        self.textFont = textFont
    }
}
