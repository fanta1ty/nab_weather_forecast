import UIKit
extension UIColor {
    convenience init(hex: Int) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let alpha, red, green, blue: UInt64
        switch hex.count {
        
        case 3:
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            
        case 6:
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            
        case 8:
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }
    
    static func getGradientRandom() -> (UIColor, UIColor) {
        return
            [(UIColor(hex: "EDF7F2"), UIColor(hex: "C7E6D4")),
             (UIColor(hex: "FFFFFF"), UIColor(hex: "EEF0F5")),
             (UIColor(hex: "FCF8E8"), UIColor(hex: "F3E3A0")),
             (UIColor(hex: "ECEEF8"), UIColor(hex: "C7CBEA")),
             (UIColor(hex: "F8ECF5"), UIColor(hex: "EED2E7")),
             (UIColor(hex: "EEF0F7"), UIColor(hex: "D6DBEB")),
             (UIColor(hex: "F4F7ED"), UIColor(hex: "D4DFB9")),
             (UIColor(hex: "FAEBEB"), UIColor(hex: "F0C2C2")),
             (UIColor(hex: "ECF4F9"), UIColor(hex: "C6DEEC"))].randomElement()!
    }
}
