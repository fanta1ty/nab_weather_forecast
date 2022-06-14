import Foundation
import UIKit

enum ProjectColor {
    case mainPrimary
    case mainSecondary
    case mainTertiary
    case mainQuaternary
    case mainQuinary
    
    case black
    case gray
    case white
    
    case background
    case error
    case success
    
    case clear
}

enum Color {
    static let iconColors = [
        UIColor(hex: 0xC6DEEC),
        UIColor(hex: 0xC7CBEA),
        UIColor(hex: 0xD8C8EA),
        UIColor(hex: 0xEED2E7),
        UIColor(hex: 0xF0C2C2),
        UIColor(hex: 0xF3E3A0),
        UIColor(hex: 0xD4DFB9),
        UIColor(hex: 0xC7E6D4)
    ]
}

extension ProjectColor {
    public var value: UIColor {
        switch self {
        case .mainPrimary: return UIColor(hex: 0x3C2665)
        case .mainSecondary: return UIColor(hex: 0x4B3B5E)
        case .mainTertiary: return UIColor(hex: 0x7C629D)
        case .mainQuaternary: return UIColor(hex: 0x7C629D)
        case .mainQuinary: return UIColor(hex: 0xB1A1C4)
            
        case .black: return UIColor(hex: 0x222222)
        case .gray: return UIColor(hex: 0x9B9B9B)
        case .white: return UIColor(hex: 0xFFFFFF)
            
        case .background: return UIColor(hex: 0xF9F9F9)
        case .error: return UIColor(hex: 0xF01F0E)
        case .success: return UIColor(hex: 0x2AA952)
            
        case .clear: return .clear
        }
    }

    public var cgValue: CGColor {
        return self.value.cgColor
    }
}
