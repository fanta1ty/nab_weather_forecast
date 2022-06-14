import Foundation
import UIKit

public enum LabelStylist {
    case headlineBold34(textColor: UIColor),
         headlineSemiBold24(textColor: UIColor),
         headlineSemiBold18(textColor: UIColor),
         subheadSemiBold16(textColor: UIColor),
         textRegular16(textColor: UIColor),
         descItemMedium14(textColor: UIColor),
         descTextRegular14(textColor: UIColor),
         helperTextRegular11(textColor: UIColor)
}

// MARK: Stylist
extension LabelStylist: Stylist {
    public typealias Element = UILabel
    
    public func style(element: UILabel) {
        switch self {
        case .headlineBold34(let color):
            styleHeadlineBold34(label: element, textColor: color)
        
        case .headlineSemiBold24(let color):
            styleHeadlineSemiBold24(label: element, textColor: color)
            
        case .headlineSemiBold18(let color):
            styleHeadlineSemiBold18(label: element, textColor: color)
            
        case .subheadSemiBold16(let color):
            styleSubheadSemiBold16(label: element, textColor: color)
            
        case .textRegular16(let color):
            styleTextRegular16(label: element, textColor: color)
            
        case .descItemMedium14(let color):
            styleDescItemMedium14(label: element, textColor: color)
            
        case .descTextRegular14(let color):
            styleDescTextRegular14(label: element, textColor: color)
            
        case .helperTextRegular11(let color):
            styleHelperTextRegular11(label: element, textColor: color)
        }
    }
    
    func styleHeadlineBold34(label: UILabel,
                             textColor: UIColor = ProjectColor.black.value,
                             fontSize: CGFloat = 34) {
        label.font = UIFont(name: ProjectFonts.metroBold.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleHeadlineSemiBold24(label: UILabel,
                                 textColor: UIColor = ProjectColor.black.value,
                                 fontSize: CGFloat = 24) {
        label.font = UIFont(name: ProjectFonts.metroSemiBold.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleHeadlineSemiBold18(label: UILabel,
                                 textColor: UIColor = ProjectColor.black.value,
                                 fontSize: CGFloat = 18) {
        label.font = UIFont(name: ProjectFonts.metroSemiBold.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleSubheadSemiBold16(label: UILabel,
                                textColor: UIColor = ProjectColor.black.value,
                                fontSize: CGFloat = 16) {
        label.font = UIFont(name: ProjectFonts.metroSemiBold.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleTextRegular16(label: UILabel,
                            textColor: UIColor = ProjectColor.black.value,
                            fontSize: CGFloat = 16) {
        label.font = UIFont(name: ProjectFonts.metroRegular.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleDescItemMedium14(label: UILabel,
                               textColor: UIColor = ProjectColor.black.value,
                               fontSize: CGFloat = 14) {
        label.font = UIFont(name: ProjectFonts.metroMedium.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleDescTextRegular14(label: UILabel,
                                textColor: UIColor = ProjectColor.black.value,
                                fontSize: CGFloat = 14) {
        label.font = UIFont(name: ProjectFonts.metroRegular.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
    
    func styleHelperTextRegular11(label: UILabel,
                                  textColor: UIColor = ProjectColor.gray.value,
                                  fontSize: CGFloat = 11) {
        label.font = UIFont(name: ProjectFonts.metroRegular.rawValue,
                            size: fontSize)
        label.textColor = textColor
    }
}
