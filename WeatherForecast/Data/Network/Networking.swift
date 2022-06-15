import Foundation
import RxSwift

protocol Networking {
    
    func get<T, P: Parser>(path: String,
                           parameters: RequestParameter?,
                           encoder: ParameterEncoder?,
                           headers: Header,
                           parser: P) -> Observable<T> where P.R == T
}
