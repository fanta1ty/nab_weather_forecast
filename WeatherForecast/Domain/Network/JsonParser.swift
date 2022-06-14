import Foundation

class JsonParser<T: Decodable>: Parser {
    
    typealias ResponseType = T
    let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse(from response: Response) throws -> T {
        guard var data = response.responseData
        else {
            let exception = TechnicalErrorException()
            exception.errorCode = "-1"
            exception.errorMessage = "data is nil"
            throw exception
        }
        do {
            if data.isEmpty {
                data = Data("{}".utf8)
            }
            let entity = try jsonDecoder.decode(T.self, from: data)
            return entity
        } catch let DecodingError.typeMismatch(type, context) {
            debugPrint("DECODE-DEBUG: Type '\(type)' mismatch:", context.debugDescription)
            debugPrint("DECODE-DEBUG: codingPath:", context.codingPath)
            let exception = TechnicalErrorException()
            exception.errorCode = "-1"
            exception.errorMessage = "Data parsed failed"
            throw exception
        }
    }
}
