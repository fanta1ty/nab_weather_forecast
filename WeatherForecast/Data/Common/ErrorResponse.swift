import Foundation

public struct ErrorResponse: Decodable {
    let error: ApiError
}

public struct ApiError: Decodable {
    let error: ApiErrorResult?
}

public struct ApiErrorResult: Decodable {
    let code: Int?
    let message: String?
    let data: DataError?
}

struct DataError: Decodable {
    let name: String?
    let debug: String?
    let message: String?
    let arguments: [String]?
    let context: Context?
}

struct Context: Decodable {
}

public struct ApiException {
    let errorCode: Int?
    let message: String?
}
