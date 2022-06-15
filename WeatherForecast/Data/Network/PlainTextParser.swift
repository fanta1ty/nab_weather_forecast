import Foundation

class PlainTextParser: Parser {
    typealias T = String
    
    func parse(from response: Response) throws -> String {
        guard let data = response.responseData,
            let result = String(data: data, encoding: .utf8)
            else { throw TechnicalErrorException(errorCode: "-1", errorMessage: "cann't parse data") }
        return result
    }
}
