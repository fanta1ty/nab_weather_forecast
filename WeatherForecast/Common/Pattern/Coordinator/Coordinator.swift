import Foundation
import RxCocoa

protocol Coordinator {
    associatedtype ResultType
    
    var identifier: UUID { get }
    func start() -> Driver<ResultType>
}
