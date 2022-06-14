import Foundation
import UIKit

enum ButtonStylist {
    case primary, secondary, outline
}

final class StyledButton: UIButton {
    var customCorner: CGFloat = 0 {
        didSet {
            isCorner = false
        }
    }
    
    var isCorner: Bool = false {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var stylist: ButtonStylist = .primary {
        didSet {
            switch stylist {
            case .outline:
                setTitleColor(ProjectColor.black.value, for: .normal)
                setTitleColor(ProjectColor.gray.value, for: .highlighted)
                titleLabel?.font = ProjectFont.textMedium(size: 14).value
                layer.borderWidth = 1.5
                
            case .secondary:
                setTitleColor(ProjectColor.white.value, for: .normal)
                setTitleColor(ProjectColor.white.value, for: .highlighted)
                
                titleLabel?.font = ProjectFont.textMedium(size: 14).value
                layer.borderWidth = 0
                
            default:
                setTitleColor(ProjectColor.white.value, for: .normal)
                setTitleColor(ProjectColor.white.value, for: .highlighted)
                
                titleLabel?.font = ProjectFont.textMedium(size: 14).value
                layer.borderWidth = 0
                
            }
        }
    }
    
    var hightLightColor: UIColor {
        switch stylist {
        case .outline:
            return ProjectColor.white.value
            
        case .secondary:
            return ProjectColor.mainSecondary.value.withAlphaComponent(0.9)
            
        default:
            return ProjectColor.mainPrimary.value.withAlphaComponent(0.9)
        }
    }
    
    var normalColor: UIColor {
        switch stylist {
        case .outline:
            return ProjectColor.white.value
            
        case .secondary:
            return ProjectColor.mainSecondary.value
            
        default:
            return ProjectColor.mainPrimary.value
        }
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        
        set {
            switch stylist {
            case .outline:
                backgroundColor = normalColor
                
                if newValue {
                    layer.borderColor = ProjectColor.gray.cgValue
                } else {
                    layer.borderColor = ProjectColor.black.cgValue
                }
                
            default:
                if newValue {
                    backgroundColor = hightLightColor
                } else {
                    backgroundColor = normalColor
                }
            }
            
            super.isHighlighted = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isSkeletonable = true
        
        let cornerRadius = frame.height / 2.0
        if isCorner {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = customCorner
        }
        
        dropShadow(cornerRadius: cornerRadius,
                   shadowColor: normalColor,
                   alpha: 0.25,
                   shadowOffsetHeight: 4)
    }
}
