import Foundation
import UIKit

class ColorUtil {
    class func computeColor(key: String) -> UIColor {
        let sum = key.map { $0.asciiValue } .reduce(0, { $0 + Int(( $1 ?? 0)) })
        return Color.iconColors[sum % Color.iconColors.count]
    }
}
