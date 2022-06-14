import UIKit

enum TextStyle: String {
    case headlineBold34,
         headlineSemiBold24,
         headlineSemiBold18,
         subheadSemiBold16,
         textRegular16,
         descItemMedium14,
         descTextRegular14,
         helperTextRegular11
    
    func style() -> UIFont.TextStyle {
        return UIFont.TextStyle(rawValue: rawValue)
    }
}
