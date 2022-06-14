import UIKit

protocol LoadingViewable {
    typealias LoadingInfo = (isShow: Bool, message: String)

    func showLoadingView(message: String, enableInteraction: Bool)
    func hideLoadingView()
}

extension LoadingViewable where Self: UIViewController {
    func showLoadingView(message: String = "", enableInteraction: Bool = false) {
        hideLoadingView()
        let animateLoading = LoadingView(frame: UIScreen.main.bounds)
        UIApplication.shared.keyWindow?.addSubview(animateLoading)
        UIApplication.shared.keyWindow?.bringSubviewToFront(animateLoading)
        animateLoading.loadingViewMessage = message
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    
    func showLoadingViewInContainerView(message: String = "",
                                        enableInteraction: Bool = false,
                                        containerView: UIView) {
        hideLoadingViewInContainerView(containerView: containerView)
        let animateLoading = LoadingView(frame: containerView.bounds, color: UIColor.clear)
        containerView.addSubview(animateLoading)
        containerView.bringSubviewToFront(animateLoading)
        animateLoading.loadingViewMessage = message
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }

    func hideLoadingView() {
        for item in UIApplication.shared.keyWindow?.subviews ?? []
        where item.isKind(of: LoadingView.self) {
            item.removeFromSuperview()
        }
    }
    
    func hideLoadingViewInContainerView(containerView: UIView) {
        for item in containerView.subviews
        where item.isKind(of: LoadingView.self) {
            item.removeFromSuperview()
        }
    }
}
