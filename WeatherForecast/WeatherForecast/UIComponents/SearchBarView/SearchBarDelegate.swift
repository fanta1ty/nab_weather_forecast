import Foundation
import UIKit

protocol SearchBarDelegate: NSObjectProtocol {
    
    func searchBarShouldBeginEditing(_ searchBar: SearchBarView) -> Bool
    func searchBarDidBeginEditing(_ searchBar: SearchBarView)
    func searchBarShouldEndEditing(_ searchBar: SearchBarView) -> Bool
    func searchBarDidEndEditing(_ searchBar: SearchBarView)
    func searchBar(_ searchBar: SearchBarView, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    func searchBarShouldClear(_ searchBar: SearchBarView) -> Bool
    func searchBarShouldReturn(_ searchBar: SearchBarView) -> Bool
    func searchBarShouldCancel(_ searchBar: SearchBarView) -> Bool
    func searchBar(_ searchBar: SearchBarView, textDidChange text: String)
}

extension SearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: SearchBarView) -> Bool {
        true
    }

    func searchBarDidBeginEditing(_ searchBar: SearchBarView) {}

    func searchBarShouldEndEditing(_ searchBar: SearchBarView) -> Bool {
        true
    }

    func searchBarDidEndEditing(_ searchBar: SearchBarView) {}

    func searchBar(_ searchBar: SearchBarView,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        true
    }

    func searchBarShouldClear(_ searchBar: SearchBarView) -> Bool {
        true
    }

    func searchBarShouldReturn(_ searchBar: SearchBarView) -> Bool {
        searchBar.textField.resignFirstResponder()
        return true
    }

    func searchBarShouldCancel(_ searchBar: SearchBarView) -> Bool {
        true
    }

    func searchBar(_ searchBar: SearchBarView, textDidChange text: String) {}
}
