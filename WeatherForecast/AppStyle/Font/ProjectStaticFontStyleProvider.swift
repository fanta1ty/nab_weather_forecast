import Foundation
import UIKit

public class ProjectStaticFontStyleProvider: FontStyleProvider {
    public func getFontStyle() -> [FontDescription] {
        
        let headlineBold34 = FontDescription(size: 34, name: ProjectFonts.robotoBold.rawValue,
                                             style: TextStyle.headlineBold34.rawValue)
        
        let headlineSemiBold24 = FontDescription(size: 24, name: ProjectFonts.robotoBlack.rawValue,
                                                 style: TextStyle.headlineSemiBold24.rawValue)
        
        let headlineSemiBold18 = FontDescription(size: 18, name: ProjectFonts.robotoBlack.rawValue,
                                                 style: TextStyle.headlineSemiBold18.rawValue)
        
        let subheadSemiBold16 = FontDescription(size: 16, name: ProjectFonts.robotoBlack.rawValue,
                                                style: TextStyle.subheadSemiBold16.rawValue)
        
        let textRegular16 = FontDescription(size: 16, name: ProjectFonts.robotoRegular.rawValue,
                                            style: TextStyle.textRegular16.rawValue)
        
        let descItemMedium14 = FontDescription(size: 14, name: ProjectFonts.robotoMedium.rawValue,
                                               style: TextStyle.descItemMedium14.rawValue)
        
        let descTextRegular14 = FontDescription(size: 14, name: ProjectFonts.robotoRegular.rawValue,
                                                style: TextStyle.descTextRegular14.rawValue)
        
        let helperTextRegular11 = FontDescription(size: 11, name: ProjectFonts.robotoRegular.rawValue,
                                                  style: TextStyle.helperTextRegular11.rawValue)
        
        let fonts = [headlineBold34,
                     headlineSemiBold24,
                     headlineSemiBold18,
                     subheadSemiBold16,
                     textRegular16,
                     descItemMedium14,
                     descTextRegular14,
                     helperTextRegular11]
        
        return fonts
    }
}

enum ProjectFonts: String {
    case metroMedium = "Metropolis-Medium",
         metroRegular = "Metropolis-Regular",
         metroSemiBold = "Metropolis-SemiBold",
         metroBold = "Metropolis-Bold"
    
    case robotoMedium = "Roboto-Medium",
         robotoRegular = "Roboto-Regular",
         robotoBold = "Roboto-Bold",
         robotoItalic = "Roboto-Italic",
         robotoLight = "Roboto-Light",
         robotoBlack = "Roboto-Black"
}

public enum ProjectFont {
    case textMedium(size: Float),
         textRegular(size: Float),
         textSemiBold(size: Float),
         textBold(size: Float),
         textLight(size: Float)
}

extension ProjectFont {
    var value: UIFont? {
        switch self {
        case .textMedium(let size):
            return UIFont(name: ProjectFonts.robotoMedium.rawValue,
                          size: CGFloat(size))
            
        case .textRegular(let size):
            return UIFont(name: ProjectFonts.robotoRegular.rawValue,
                          size: CGFloat(size))
            
        case .textSemiBold(let size):
            return UIFont(name: ProjectFonts.robotoBlack.rawValue,
                          size: CGFloat(size))
            
        case .textBold(let size):
            return UIFont(name: ProjectFonts.robotoBold.rawValue,
                          size: CGFloat(size))
            
        case .textLight(let size):
            return UIFont(name: ProjectFonts.robotoLight.rawValue,
                          size: CGFloat(size))
        }
    }
}
