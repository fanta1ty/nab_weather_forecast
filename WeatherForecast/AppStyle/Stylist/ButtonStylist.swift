import UIKit

// MARK: Stylist
extension ButtonStylist: Stylist {
    public typealias Element = UIButton
    
    public func style(element: UIButton) {
        switch self {
        case .secondary:
            styleSecondaryButton(element)
            
        default:
            stylePrimaryButton(element)
        }
    }
    
    private func stylePrimaryButton(_ button: UIButton) {
        button.titleLabel?.font = UIFont(name: ProjectFonts.metroMedium.rawValue, size: 14)
        button.setTitleColor(ProjectColor.white.value, for: .normal)
        
        button.layer.masksToBounds = true
        
        // disabled
        button.setTitleColor(ProjectColor.white.value.withAlphaComponent(0.3), for: .disabled)
    }
    
    private func styleSecondaryButton(_ button: UIButton) {
        button.setTitleColor(ProjectColor.white.value, for: .normal)
        button.setTitleColor(ProjectColor.white.value.withAlphaComponent(0.5), for: .highlighted)
        button.titleLabel?.font = UIFont(name: ProjectFonts.metroMedium.rawValue, size: 14)
        button.backgroundColor = ProjectColor.mainTertiary.value
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = ProjectColor.mainPrimary.value.cgColor
        
        //disabled
        button.setTitleColor(ProjectColor.white.value.withAlphaComponent(0.3), for: .disabled)
    }
    
}
