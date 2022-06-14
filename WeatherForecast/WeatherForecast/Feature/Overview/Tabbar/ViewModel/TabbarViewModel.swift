import Foundation
import RxSwift

protocol TabbarViewModel: BaseViewModel {
    var input: DashboardInput { get }
    var output: DashboardOutput { get }
}

protocol DashboardInput {
    
}

protocol DashboardOutput {
}
