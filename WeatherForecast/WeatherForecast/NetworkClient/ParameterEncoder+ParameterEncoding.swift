import Foundation
import Alamofire

extension ParameterEncoder {
    var encoding: ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        }
    }
}
