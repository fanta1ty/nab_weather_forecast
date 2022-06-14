import UIKit
import RxSwift

class BaseTabBarViewController<ViewModel>: UITabBarController {

    var localization: Localizable!
    var viewModel: ViewModel!
    var disposeBag = DisposeBag()

    convenience init(viewModel: ViewModel, localization: Localizable) {
        self.init()
        self.localization = localization
        self.viewModel = viewModel
        bindControllerLifeCircle()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeUpViews()
        localize()
        bindingData()
    }
    
    private func bindControllerLifeCircle() {
        guard let viewModel = viewModel as? BaseViewModelImpl else { return }
        rx.onViewDidLoad.bind(to: viewModel.onViewDidLoad).disposed(by: disposeBag)
        rx.onViewWillAppear.bind(to: viewModel.onViewWillAppear).disposed(by: disposeBag)
        rx.onViewDidAppear.bind(to: viewModel.onViewDidAppear).disposed(by: disposeBag)
        rx.onViewDidDisappear.bind(to: viewModel.onViewDidDisappear).disposed(by: disposeBag)
    }
    
    func bindingData() {}
    
    func makeUpViews() {}
    
    func localize() {}
}
