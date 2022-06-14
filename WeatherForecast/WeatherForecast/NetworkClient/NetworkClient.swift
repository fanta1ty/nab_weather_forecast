import Foundation
import RxSwift
import Alamofire
import UIKit

public class NetworkClient {
    
    private let baseUrl: URL
    
    var AFSessionManager: SessionManager?
    
    init?(endPoint: String) {
        guard let url = URL(string: endPoint)
        else {
            Log.d("endPoint: \(endPoint) is not an URL")
            return nil
        }
        baseUrl = url
        configureAlamofireSSLPinning(endpoint: endPoint)
    }
    
    func request<T, P: Parser>(requestInformation: RequestInformation,
                               parser: P) -> Observable<T> where P.R == T {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            guard let url = URL(string: requestInformation.path, relativeTo: self.baseUrl)
            else {
                let baseURlString = self.baseUrl.absoluteString
                let path = requestInformation.path
                let message = "baseUrl: \(baseURlString) and path: \(path) is not an URL"
                Log.e(message)
                observer.onError(BaseErrorException(errorCode: "-1", errorMessage: message))
                observer.onCompleted()
                return Disposables.create()
            }
            
            let parameterEncoder = requestInformation.parameterEncoding?.encoding ?? JSONEncoding.default
            let headers = requestInformation.headers.requestHeader
            let parameter = requestInformation.parameters?.requestParameter
            
            // DISABLE REDIRECT URL FOR AUTHORIZE CALLBACK URL
            self.AFSessionManager!
                .delegate
                .taskWillPerformHTTPRedirection = { (_, _, response, request) -> URLRequest? in
                    return nil
                }
            
            var request: DataRequest?
            request = self.AFSessionManager!.request(url,
                                                     method: requestInformation.method,
                                                     parameters: parameter,
                                                     encoding: parameterEncoder,
                                                     headers: headers)
            
            self.debugPrintLogs(request: request!, requestInformation: requestInformation)
            
            request!
                .validate(statusCode: 200...302)
                .responseData { [weak self] response in
                    guard let self = self else { return }
                    let httpCode = response.response?.statusCode ?? 0
                    
                    debugPrint(" ================> RESPONSE ----------------------------")
                    Log.d("Response from \(response.request!) - HTTP code \(httpCode)")
                    Log.d("Response Raw Data Header:")
                    response.headers.forEach {
                        Log.d("header \($0): \($1)")
                    }
                    Log.d("Response Raw Data Body:")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        Log.d("Body: \(utf8Text)")
                    }
                    
                    switch response.result {
                    case .failure(_):
                        let errorException = ApiException(errorCode: 500,
                                                          message: "Odoo Server Error")
                        
                        self.handleError(errorException, with: response,
                                         parser: parser,
                                         observer: observer)
                    case.success:
                        let errorParser = JsonParser<ApiError>(jsonDecoder: JSONDecoder())
                        if let errorDecoded = try? errorParser.parse(from: response),
                           let errorCode = errorDecoded.error?.code {
                            let error = ApiException(errorCode: errorCode,
                                                     message: errorDecoded.error?.data?.message)
                            self.handleError(error,
                                             with: response,
                                             parser: parser,
                                             observer: observer)
                            
                        } else {
                            self.handleSuccessResponse(response,
                                                       parser: parser,
                                                       with: observer)
                        }
                    }
                }
            return Disposables.create {
                request!.cancel()
            }
        }.share(replay: 1)
    }
    
    private func debugPrintLogs(request: DataRequest, requestInformation: RequestInformation) {
        let parameter = requestInformation.parameters?.requestParameter
        let headers = requestInformation.headers.requestHeader
        
        debugPrint(" ================> REQUEST ----------------------------")
        Log.d("\(String(describing: request.request))")
        Log.d("\(String(describing: request.request!.httpMethod))")
        Log.d("Request Header:")
        headers.forEach {
            Log.d(" header \($0): \($1)")
        }
        Log.d("Request Body:")
        Log.d(" paramter: \(String(describing: parameter))")
    }
    
    private func handleError<T, P: Parser>(_ error: ApiException,
                                           with response: DataResponse<Data>,
                                           parser: P,
                                           observer: AnyObserver<T>) where P.R == T {
        
        Log.d("catch handle error: \(error)")
        let exception = BaseErrorException()
        exception.errorCode = "\(error.errorCode ?? 0)"
        exception.errorMessage = error.message ?? ""
        observer.onError(exception)
        return
    }
    
    private func handleSuccessResponse<T, P: Parser>(_ response: DataResponse<Data>, parser: P,
                                                     with observer: AnyObserver<T>) where P.R == T {
        do {
            let dataDecoded: T = try parser.parse(from: response)
            
            let resultData = "\(dataDecoded)"
            Log.d("  - Response dataDecoded - \(resultData)")
            if resultData.contains("uid") {
                Log.d("\n\n  ---- Response Login ---- \n\n")
                let responseHeader = response.headers["Set-Cookie"]
                let cookieHeader = "\(String(describing: responseHeader))"
                if !cookieHeader.isEmpty {
                    let cookie = cookieHeader.components(separatedBy: "; ")
                    AppSessionManager.shared.authorizationToken = cookie[0]
                }
            }
            
            observer.onNext(dataDecoded)
            observer.onCompleted()
        } catch let error {
            Log.d("  - Response Parser error - \(error)")
            observer.onError(error)
        }
    }
}

// MARK: - SSL PINNING CONFIG
extension NetworkClient {
    func configureAlamofireSSLPinning(endpoint: String) {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = TimeInterval(AppConstants.General.apiCallTimeout)
        
        self.AFSessionManager = SessionManager(configuration: configuration)
    }
}
