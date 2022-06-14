import Foundation
import UIKit

struct SearchBarConfig {
    /// Animation duration for showing/hiding the cancel button.
    var animationDuration: TimeInterval = 0.25

    /// The width and height for one square of the layout raster.
    /// All sizes, margins, distances, etc. are calculated as multiples of this value.
    var rasterSize: CGFloat = 11.0

    /// The attributes to format the searchbars text.
    var textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ProjectColor.black.value]

    /// The textContentType property is to provide the keyboard with extra
    /// information about the semantic intent of the text document.
    var textContentType: String?

    /// Controls the visibility of the cancel button
    var useCancelButton: Bool = true

    /// The title of the cancel button.
    var cancelButtonTitle: String = "Cancel"

    /// The text attributes to style the cancel button.
    var cancelButtonTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ProjectColor.mainPrimary.value]

    /// The left accessory view of the searchbar. For searchbars there is typically a search glass.
    var leftView: UIView?

    /// The left view mode of the searchbar regarding to a leftView.
    var leftViewMode: UITextField.ViewMode = .never

    /// The right accessory view of the searchbar. For searchbars there is typically a search glass.
    var rightView: UIView?

    /// The right view mode of the searchbar regarding to a rightView.
    var rightViewMode: UITextField.ViewMode = .always

    /// Controls when to show the clear button.
    var clearButtonMode: UITextField.ViewMode = .whileEditing

    init() {
    }
}
