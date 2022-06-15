import Foundation

class BaseErrorException: Error {
    var errorCode: String = ""
    var errorMessage: String = ""
    init(errorCode: String,
         errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
    init() {
    }
}

enum NetworkExceptionType {
    case internetConnectionError
    case timeout
    case unknownHost
    case unknownError
}

class NetworkErrorException: BaseErrorException {
    var exceptionType: NetworkExceptionType = NetworkExceptionType.unknownError
}

class TechnicalErrorException: BaseErrorException {
}

class BusinessErrorException: BaseErrorException {

}

class UnauthorizedErrorException: BaseErrorException {

}

class RequiredStepUpTokenException: BusinessErrorException {
    var requestToken = ""
    init(requestToken: String) {
        super.init()
        self.requestToken = requestToken
    }
}
