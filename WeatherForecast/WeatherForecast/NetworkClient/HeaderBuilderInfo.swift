import Foundation
    
func requestHeaderBuilder() -> [String: String] {
    var headers = [String: String]()
    headers[RequestHeader.Key.contentType] = RequestHeader.Value.jsonPlancontentType
    return headers
}
