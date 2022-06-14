import Foundation
import UIKit
import SnapKit

// swiftlint:disable file_length
final class SearchBarView: UIView, SearchBarDelegate {
    /// The content of this property is used to restore the textField text after cancellation
    var textBeforeEditing: String?
    
    /// Constraint that shows the cancel button when active
    var bgToCancelButtonConstraint: NSLayoutConstraint!
    
    /// Constraint that hides the cancel button when active
    var bgToParentConstraint: NSLayoutConstraint!

    /// The background image view which is responsible for displaying the rounded corners.
    let backgroundView: UIImageView = UIImageView()

    /// The cancel button under the right side of the searhcbar.
    let cancelButton: UIButton = UIButton(type: .custom)

    let textField: UITextField

    /// The central SearchBarConfig instance which configures all searchbar parameters.
    var config: SearchBarConfig {
        didSet {
            if let textField = textField as? SearchBarTextField {
                textField.config = config
            }
            updateUserInterface()
            updateViewConstraints()
        }
    }
    
//    override var intrinsicContentSize: CGSize {
//        return UIView.layoutFittingExpandedSize
//    }

    /// You can set the searchbar as inactive with this property. Currently this only dims the text color slightly.
    var isActive: Bool = true {
        didSet {
            updateUserInterface()
        }
    }

    /// The text of the searchbar. Defaults to nil.
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    /// The placeholder of the searchbar. Defaults to nil.
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    /// The text alignment of the searchbar.
    var textAlignment: NSTextAlignment {
        get { textField.textAlignment }
        set { textField.textAlignment = newValue }
    }
    
    /// The enabled state of the searchbar.
    var isEnabled: Bool {
        get { textField.isEnabled }
        set { textField.isEnabled = newValue }
    }

    /// The delegate which informs the user about important events.
    weak var delegate: SearchBarDelegate?

    init(config: SearchBarConfig) {
        self.config = config
        self.textField = SearchBarTextField(config: config)

        super.init(frame: CGRect.zero)

        self.delegate = self
        translatesAutoresizingMaskIntoConstraints = false

        setupBackgroundView(withConfig: config)
        setupTextField(withConfig: config)
        setupCancelButton(withConfig: config)

        backgroundView.addSubview(textField)
        addSubview(cancelButton)
        addSubview(backgroundView)

        updateViewConstraints()

        updateUserInterface()
    }

    func setupBackgroundView(withConfig config: SearchBarConfig) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isUserInteractionEnabled = true
        updateBackgroundImage(withRadius: 0, corners: .allCorners, color: UIColor.white)
    }

    func setupTextField(withConfig config: SearchBarConfig) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.adjustsFontSizeToFitWidth = false
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }

    func setupCancelButton(withConfig config: SearchBarConfig) {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.alpha = 0.0
        cancelButton.setContentHuggingPriority(.required, for: .horizontal)
        cancelButton.reversesTitleShadowWhenHighlighted = true
        cancelButton.adjustsImageWhenHighlighted = true
        cancelButton.addTarget(self, action: #selector(pressedCancelButton(_:)), for: .touchUpInside)
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateViewConstraints() {
        let isInitialUpdate = backgroundView.constraints.isEmpty
        let isTextFieldInEditMode = bgToCancelButtonConstraint?.isActive ?? false

        bgToParentConstraint?.isActive = false
        bgToCancelButtonConstraint?.isActive = false

        if isInitialUpdate {
            let constraints = [
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

                textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
                textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
                textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

                cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                cancelButton.topAnchor.constraint(equalTo: topAnchor),
                cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)

            bgToParentConstraint = backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
            bgToCancelButtonConstraint = backgroundView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor,
                                                                                  constant: -config.rasterSize)
        }

        bgToCancelButtonConstraint.constant = -config.rasterSize

        if isTextFieldInEditMode && !isInitialUpdate && config.useCancelButton {
            bgToCancelButtonConstraint.isActive = true
        } else {
            bgToParentConstraint.isActive = true
        }
    }

    // MARK: - First Responder Handling
    override var isFirstResponder: Bool {
        textField.isFirstResponder
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }

    override var canResignFirstResponder: Bool {
        textField.canResignFirstResponder
    }

    override var canBecomeFirstResponder: Bool {
        textField.canBecomeFirstResponder
    }

    // MARK: - UI Updates
    func updateUserInterface() {
        var textColor = config.textAttributes[.foregroundColor] as? UIColor ?? ProjectColor.mainPrimary.value

        // Replace normal color with a lighter color so the text looks disabled
        if !isActive { textColor = textColor.withAlphaComponent(0.5) }

        textField.tintColor = textColor // set cursor color
        textField.textColor = textColor

        textField.leftView = config.leftView
        textField.leftViewMode = config.leftViewMode

        textField.rightView = config.rightView
        textField.rightViewMode = config.rightViewMode

        textField.clearButtonMode = config.clearButtonMode

        var textAttributes = config.textAttributes
        textAttributes[.foregroundColor] = textColor
        textField.defaultTextAttributes = textAttributes

        let normalAttributes = config.cancelButtonTextAttributes
        cancelButton.setAttributedTitle(NSAttributedString(string: config.cancelButtonTitle,
                                                           attributes: normalAttributes), for: .normal)
        var highlightedAttributes = config.cancelButtonTextAttributes
        let highlightColor = highlightedAttributes[.foregroundColor] as? UIColor ?? ProjectColor.black.value
        
        highlightedAttributes[.foregroundColor] = highlightColor.withAlphaComponent(0.75)
        cancelButton.setAttributedTitle(NSAttributedString(string: config.cancelButtonTitle,
                                                           attributes: highlightedAttributes),
                                        for: .highlighted)

        if #available(iOS 10.0, *) {
            if let textContentType = config.textContentType {
                textField.textContentType = UITextContentType(rawValue: textContentType)
            }
        }
    }

    /**
     * Use this function to specify the views corner radii. They will be applied to the background
     * image view that spans the whole search bar. The backgroundColor of this view must remain clear to
     * make the corner radius visible.
     */
    func updateBackgroundImage(withRadius radius: CGFloat, corners: UIRectCorner, color: UIColor) {
        let insets = UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius)
        let imgSize = CGSize(width: radius * 2 + 1, height: radius * 2 + 1)
        var img = UIImage.imageWithSolidColor(color, size: imgSize)
        img = img.roundedImage(with: radius, cornersToRound: corners)
        img = img.resizableImage(withCapInsets: insets)
        backgroundView.image = img
        backgroundColor = UIColor.clear
    }

    /**
     * Resets the textFields content to the value when etiting has been started.
     * This function is called when the cancel button has been pressed.
     */
    func resetTextField() {
        let oldText = textField.text
        textField.text = textBeforeEditing
        if oldText != textField.text {
            delegate?.searchBar(self, textDidChange: "")
        }
    }

    // MARK: - Cancel Button Management
    func cancelSearch() {

        let shouldCancel = delegate?.searchBarShouldCancel(self) ?? searchBarShouldCancel(self)
        if shouldCancel {
            resetTextField()
            textField.resignFirstResponder()
        }
    }

    @objc func pressedCancelButton(_ sender: AnyObject) {

        cancelSearch()
    }

    func updateCancelButtonVisibility(makeVisible show: Bool) {

        // This 'complex' if-else avoids constraint warnings in the console
        if show && config.useCancelButton {
            bgToParentConstraint.isActive = false
            bgToCancelButtonConstraint.isActive = true
        } else {
            bgToCancelButtonConstraint.isActive = false
            bgToParentConstraint.isActive = true
        }

        UIView.animate(withDuration: config.animationDuration, delay: 0, options: [], animations: {
            self.layoutIfNeeded()
            self.cancelButton.alpha = show ? 1 : 0
        }, completion: nil)
    }

    // MARK: - Handle Text Changes

    @objc func didChangeTextField(_ textField: UITextField) {

        let newText = textField.text ?? ""
        delegate?.searchBar(self, textDidChange: newText)
    }
    
    static func defaultSearchBar() -> SearchBarView {
        var config = SearchBarConfig()
        if #available(iOS 13.0, *) {
            let leftView = imageViewWithIcon(Asset.icSearch.image,
                                             raster: 11.0)
            config.leftView = leftView
        } else {
            let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
            leftImageView.image = Asset.icSearch.image
            leftImageView.contentMode = .center
            config.leftView = leftImageView
        }
        
        config.leftViewMode = .always
        config.useCancelButton = true
        config.textContentType = UITextContentType.fullStreetAddress.rawValue
        
        let result = SearchBarView(config: config)
        result.placeholder = "Search"
        result.updateBackgroundImage(withRadius: 6, corners: [.allCorners],
                                     color: UIColor.white)
        return result
    }
    
    static func imageViewWithIcon(_ icon: UIImage, raster: CGFloat) -> UIView {
        let imgView = UIImageView(image: icon)
        imgView.translatesAutoresizingMaskIntoConstraints = false

        imgView.contentMode = .center
        imgView.tintColor = ProjectColor.mainPrimary.value

        let container = UIView()
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
                                                                     leading: raster,
                                                                     bottom: 0,
                                                                     trailing: raster)
        container.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),
            imgView.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
            imgView.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor)
        ])

        return container
    }
}

// MARK: - UITextFieldDelegate

extension SearchBarView: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldBegin = delegate?.searchBarShouldBeginEditing(self) ?? searchBarShouldBeginEditing(self)
        if shouldBegin {
            updateCancelButtonVisibility(makeVisible: true)
        }
        return shouldBegin
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textBeforeEditing = textField.text
        delegate?.searchBarDidBeginEditing(self)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let shouldEnd = delegate?.searchBarShouldEndEditing(self) ?? searchBarShouldEndEditing(self)
        if shouldEnd {
            updateCancelButtonVisibility(makeVisible: false)
        }
        return shouldEnd
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing(self)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let delegate = delegate else {
            return searchBar(self, shouldChangeCharactersIn: range, replacementString: string)
        }
        return delegate.searchBar(self, shouldChangeCharactersIn: range, replacementString: string)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let shouldClear = delegate?.searchBarShouldClear(self) ?? searchBarShouldClear(self)
        return shouldClear
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shouldReturn = delegate?.searchBarShouldReturn(self) ?? searchBarShouldReturn(self)
        return shouldReturn
    }
}

extension NSLayoutDimension {

@discardableResult
func set(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {

        let cons = constraint(equalToConstant: constant)
        cons.priority = priority
        cons.isActive = true
        return cons
    }
}
