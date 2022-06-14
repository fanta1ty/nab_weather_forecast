import Foundation
import UIKit
import SnapKit

final class NDefaultView: UIView {
    private let identityView = "NDefaultView"

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var rightActionBtn: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    var onActionClosure: (() -> Void)?
    var onRightActionClosure: (() -> Void)?
    
    var leftButtonType: NavigationBarButtonType! {
        didSet {
            switch leftButtonType {
            case .back:
                logoImageView.image = Asset.icBack.image
                
            case .close:
                logoImageView.image = Asset.icCloseWhite.image
                
            default:
                logoImageView.image = nil
            }
        }
    }
    
    var rightButtonType: NavigationBarButtonType! {
        didSet {
            switch rightButtonType {
            case .cancel:
                rightActionBtn.isHidden = false
                
            default:
                rightActionBtn.isHidden = true
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed(identityView, owner: self, options: nil)
        setupUI()
    }
        
    init() {
        super.init(frame: .zero)
        Bundle.main.loadNibNamed(identityView, owner: self, options: nil)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(identityView, owner: self, options: nil)
        
        setupUI()
    }
    
    @IBAction func onActionBtn(_ sender: Any) {
        onActionClosure?()
    }
    
    @IBAction func onRightActionBtn(_ sender: Any) {
        onRightActionClosure?()
    }
}

extension NDefaultView {
    func setupUI() {
        view.fixInView(self)
        
        logoImageView.tintColor = .white
        rightActionBtn.tintColor = .white
        rightActionBtn.isHidden = true
    }
}
