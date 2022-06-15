import Foundation

public enum RequestHeader {
    enum Key {
        static let authorization = "Cookie"
        static let contentType = "Content-Type"
        static let channel = "Channel"
        static let timeStamp = "Timestamp"
    }
    
    enum Value {
        static let textPlancontentType = "text/plain"
        static let jsonPlancontentType = "application/json"
        static let correlationId = UUID().uuidString.lowercased()
        static let accept = "application/json, text/plain, */*"
        static let channel = "iOS"
    }
}

public enum RequestField {
    enum General {
        static let params = "params"
    }
    
    enum WeatherForecast {
        static let city = "q"
        static let days = "cnt"
        static let appId = "appid"
        static let unit = "units"
    }
}
