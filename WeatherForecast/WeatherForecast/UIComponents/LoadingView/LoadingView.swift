import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animateView: AnimateLoadingView!
    @IBOutlet weak var containerView: UIView!
    
    var backgroundContainerView: UIColor?
    public var loadingViewMessage: String! {
        didSet {
            messageLabel.text = loadingViewMessage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundContainerView = color
        commonInit()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        animateView.color = ProjectColor.mainPrimary.value
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(containerView)
        containerView.addBackgroundForLoading(area: bounds,
                                              color: backgroundContainerView ?? .black)
        containerView.bringSubviewToFront(messageLabel)
    }
    
    public func startAnimation() {
        if animateView.isAnimating { return }
        animateView.startAnimating()
    }
    
    public func stopAnimation() {
        animateView.stopAnimating()
    }
}
