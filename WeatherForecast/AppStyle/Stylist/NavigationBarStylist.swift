import UIKit

enum NavigationBarStylist {
    case primary
}

extension NavigationBarStylist: Stylist {
    typealias Element = UINavigationBar

    func style(element: UINavigationBar) {
        switch self {
        default:
            makeupPrimaryNavigationBar(element: element)
        }
    }

    private func makeupGeneral(element: UINavigationBar) {
        if #available(iOS 13.0, *) {
            let standartAppearence = UINavigationBarAppearance()
            standartAppearence.shadowColor = .clear
            standartAppearence.backgroundEffect = .none
            standartAppearence.backgroundColor = UIColor.clear
            let backButtonAppearence = UIBarButtonItemAppearance()
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            backButtonAppearence.normal.titleTextAttributes = titleTextAttributes
            backButtonAppearence.highlighted.titleTextAttributes = titleTextAttributes
            standartAppearence.backButtonAppearance = backButtonAppearence
            UINavigationBar.appearance().standardAppearance = standartAppearence
            UINavigationBar.appearance().compactAppearance = standartAppearence
        } else {
            
            element.setBackgroundImage(UIImage(), for: .default)
            element.shadowImage = UIImage()
            element.isTranslucent = false
            element.barTintColor = ProjectColor.mainPrimary.value
    
            let clearBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            element.topItem?.backBarButtonItem = clearBackButton
        }
    }

    private func makeupPrimaryNavigationBar(element: UINavigationBar) {
        makeupGeneral(element: element)

        element.tintColor = ProjectColor.mainPrimary.value
        
        if #available(iOS 13.0, *) {
            element.standardAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: ProjectFont.textSemiBold(size: 18).value!,
                NSAttributedString.Key.foregroundColor: ProjectColor.mainPrimary.value
            ]
            
            element.standardAppearance.largeTitleTextAttributes = [
                NSAttributedString.Key.font: ProjectFont.textBold(size: 34).value!,
                NSAttributedString.Key.foregroundColor: ProjectColor.mainPrimary.value
            ]
        } else {
            element.titleTextAttributes = [
                NSAttributedString.Key.font: ProjectFont.textSemiBold(size: 18).value!,
                NSAttributedString.Key.foregroundColor: ProjectColor.mainPrimary.value
            ]
            element.largeTitleTextAttributes = [
                NSAttributedString.Key.font: ProjectFont.textBold(size: 34).value!,
                NSAttributedString.Key.foregroundColor: ProjectColor.mainPrimary.value
            ]
        }
    }
}
