import Foundation
import Alamofire

extension DataResponse: Response where Value == Data {
    
    var responseData: Data? {
        return data
    }
    
    var httpStatusCode: Int {
        return response?.statusCode ?? 0
    }
    
    var headers: [AnyHashable: Any] {
        return response?.allHeaderFields ?? [:]
    }
    
    var url: URL? {
        return response?.url
    }
}
