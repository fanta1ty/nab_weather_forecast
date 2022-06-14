import Foundation

class DefaultLocalization: Localizable {
    func localize(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
