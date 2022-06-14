import Foundation
import UIKit

extension String {
    func convertDobForServer() -> String {
        var result = ""
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: self)
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        result = dateFormatter.string(from: date ?? Date())
        
        return result
    }
    
    func convertDobForReader() -> String {
        var result = ""
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: self)
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        result = dateFormatter.string(from: date ?? Date())
        
        return result
    }
    
    func convertCreatedOrderForReader() -> String {
        var result = ""
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: self)
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm, dd/MM/yyyy"
        
        result = dateFormatter.string(from: date ?? Date())
        
        return result
    }
    
    func getRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex,
                                     offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex,
                                   offsetBy: nsRange.location + nsRange.length,
                                   limitedBy: utf16.endIndex),
            let start = from16.samePosition(in: self),
            let end = to16.samePosition(in: self)
            else { return nil }
        return start ..< end
    }

    func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji() })
    }
    
    func toStrikeAttributeString(font: UIFont, color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any]
            = [.font: font,
               .foregroundColor: color,
               .strikethroughStyle: NSUnderlineStyle.single.rawValue,
               .strikethroughColor: color]
        
        return NSAttributedString(string: self,
                                  attributes: attributes)
    }
    
    func isValidEmail() -> Bool {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", ValidationConstants.emailPattern)
        let lowerStr = self.lowercased()
        return emailPred.evaluate(with: lowerStr)
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = createSeparatorForrmatter()
    static let withSeparatorNonZeroes: NumberFormatter = createSeparatorForrmatter(minimumFractionDigits: 0)
    
    static func createSeparatorForrmatter(minimumFractionDigits: Int = 0) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        formatter.groupingSize = 3
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
