import Foundation
import RxSwift

extension NetworkClient: Networking {
    func get<T, P: Parser>(path: String,
                           parameters: RequestParameter?,
                           encoder: ParameterEncoder?,
                           headers: Header,
                           parser: P) -> Observable<T> where P.R == T {
        let requestInfo = RequestInformation(method: .get,
                                             path: path,
                                             parameters: parameters,
                                             parameterEncoding: encoder,
                                             headers: headers)
        return request(requestInformation: requestInfo, parser: parser)
    }
}

extension Dictionary: RequestParameter {
    var requestParameter: [String: Any] {
        return ["{": "}"]
    }
}
