import Foundation
import Alamofire

struct RequestInformation {
    let method: HTTPMethod
    let path: String
    let parameters: RequestParameter?
    let parameterEncoding: ParameterEncoder?
    let headers: Header
    let parmeterString: String?
    
    init(method: HTTPMethod,
         path: String,
         parameters: RequestParameter?,
         parameterString: String? = nil,
         parameterEncoding: ParameterEncoder?,
         headers: Header) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
        self.headers = headers
        self.parmeterString = parameterString
    }
}
