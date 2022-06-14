import UIKit
import RxSwift
import RxCocoa
import SkeletonView

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable file_length
// swiftlint:disable function_body_length
class MainViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    override func makeUpViews() {
        super.makeUpViews()
        
        setupUI()
    }
}

extension MainViewController {
    func setupUI() {
        
        topConstraint.constant = NavigationBarManager.bottomConstraint
        
        if let customNav = customNav as? NMainView {
            customNav.titleLb.text = L10n.Dashboard.title
            
            customNav.searchTextDidChange = { searchStr in
                Log.d("Search: \(searchStr)")
            }
        }
        
    }
}
