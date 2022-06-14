import UIKit
import RxCocoa

class SplashViewController: BaseViewController<SplashViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input
            .startPushToDashboard.onNext(())
    }
}
