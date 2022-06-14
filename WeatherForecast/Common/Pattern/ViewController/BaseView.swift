import Foundation
import UIKit

class BaseView: UIView {
    
    //Outlets
    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(getIdentityView(), owner: self, options: nil)
        contentView.backgroundColor = UIColor.clear
    }
    
    func getIdentityView() -> String {
        return "\(type(of: self))"
    }
}
