import Foundation
import RxSwift

final class TabbarViewModelImpl: BaseViewModelImpl {
    
}

extension TabbarViewModelImpl: TabbarViewModel {
    var input: DashboardInput {
        return self
    }
    
    var output: DashboardOutput {
        return self
    }
}

extension TabbarViewModelImpl: DashboardInput {
    
}

extension TabbarViewModelImpl: DashboardOutput {
    
}
