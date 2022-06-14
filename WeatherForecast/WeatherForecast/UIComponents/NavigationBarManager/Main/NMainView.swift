import Foundation
import UIKit
import SnapKit

final class NMainView: UIView {
    private let identityView = "NMainView"
    @IBOutlet var view: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    
    var searchTextDidChange: ((String) -> Void)?
    
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
}

extension NMainView: SearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: SearchBarView) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: SearchBarView, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: SearchBarView, textDidChange text: String) {
        searchTextDidChange?(text)
    }
}

extension NMainView {
    func setupUI() {
        view.fixInView(self)
        titleLb.font = ProjectFont.textMedium(size: 17).value
        
        let searchBar = SearchBarView.defaultSearchBar()
        searchBar.config.useCancelButton = true
        searchBar.delegate = self
        
        searchView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
