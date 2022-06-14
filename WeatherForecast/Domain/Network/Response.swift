import Foundation

protocol Response {
    var responseData: Data? { get }
    var httpStatusCode: Int { get }
    var headers: [AnyHashable: Any] { get }
    var url: URL? { get }
}
