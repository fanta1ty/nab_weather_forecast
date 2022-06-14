import UIKit

class TabbarViewController: BaseTabBarViewController<TabbarViewModel> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBagBadgeNumber(_:)),
                                               name: .updateBadgeCartNumber, object: nil)
    }
    
    override func makeUpViews() {
        tabBar.backgroundColor = ProjectColor.white.value
        tabBar.tintColor = ProjectColor.mainPrimary.value
        tabBar.barTintColor = ProjectColor.white.value
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Functions
extension TabbarViewController {
    @objc func updateBagBadgeNumber(_ notification: Notification) {
        let key = AppConstants.ObjectKey.badgeCartNumber
        if let tabItem = tabBar.items?[2],
           let badgeCartNumber = notification.userInfo?[key] as? Int {
            if badgeCartNumber == 0 {
                tabItem.badgeValue = nil
            } else {
                tabItem.badgeValue = "\(badgeCartNumber)"
            }
        }
    }
}
