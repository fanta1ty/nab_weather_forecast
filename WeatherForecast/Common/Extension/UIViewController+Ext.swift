//
//  UIViewController+Ext.swift
//  ExampleConcept
//
//  Created by Thinh Nguyen on 7/22/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for `showLoadingView(message: String)`, `hideLoadingView()` methods.
    var isShowingLoadingView: Binder<LoadingViewable.LoadingInfo> {
        return Binder(self.base, binding: { (viewController, loadingInfo) in
            if loadingInfo.isShow {
                viewController.showLoadingView(message: loadingInfo.message)
            } else {
                viewController.hideLoadingView()
            }
        })
    }
    
}
