import Foundation
import RxSwift

extension NetworkClient: Networking {

    func post<T, P: Parser>(path: String,
                            parameters: RequestParameter?,
                            encoder: ParameterEncoder?,
                            headers: Header,
                            parser: P) -> Observable<T> where P.R == T {
        let requestInfo = RequestInformation(method: .post,
                                             path: path,
                                             parameters: parameters,
                                             parameterEncoding: encoder,
                                             headers: headers)
        Log.d("Request params: \(String(describing: parameters))")
        return request(requestInformation: requestInfo, parser: parser)
    }

    func post<T, P>(path: String,
                    parameterStringArray: [String],
                    encoder: ParameterEncoder?,
                    headers: Header, parser: P) -> Observable<T> where T == P.R, P: Parser {
        let paramString = String.init(format: "[%@]", parameterStringArray.joined(separator: ", "))
        let requestInfo = RequestInformation(method: .post,
                                             path: path,
                                             parameters: nil,
                                             parameterString: paramString,
                                             parameterEncoding: encoder,
                                             headers: headers)
        Log.d("Request params: \(parameterStringArray)")
        return request(requestInformation: requestInfo, parser: parser)
    }

    func put<T, P: Parser>(path: String,
                           parameters: RequestParameter?,
                           encoder: ParameterEncoder?,
                           headers: Header,
                           parser: P) -> Observable<T> where P.R == T {
        let requestInfo = RequestInformation(method: .put,
                                             path: path,
                                             parameters: parameters,
                                             parameterEncoding: encoder,
                                             headers: headers)
        return request(requestInformation: requestInfo, parser: parser)
    }

    func delete<T, P: Parser>(path: String,
                              parameters: RequestParameter?,
                              encoder: ParameterEncoder?,
                              headers: Header,
                              parser: P) -> Observable<T> where P.R == T {
        let requestInfo = RequestInformation(method: .delete,
                                             path: path,
                                             parameters: parameters,
                                             parameterEncoding: encoder,
                                             headers: headers)
        return request(requestInformation: requestInfo, parser: parser)
    }

    func deleteNoContentRequest<T, P: Parser>(path: String,
                                              encoder: ParameterEncoder?,
                                              headers: Header,
                                              parser: P) -> Observable<T> where P.R == T {
        let requestInfo = RequestInformation(method: .delete,
                                             path: path,
                                             parameters: ["{": "}"],
                                             parameterString: "{}",
                                             parameterEncoding: encoder,
                                             headers: headers)
        return request(requestInformation: requestInfo, parser: parser)
    }

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

    func patch<T, P>(path: String,
                     parameters: RequestParameter?,
                     encoder: ParameterEncoder?,
                     headers: Header,
                     parser: P) -> Observable<T> where T == P.R, P: Parser {
        let requestInfo = RequestInformation(method: .patch,
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
