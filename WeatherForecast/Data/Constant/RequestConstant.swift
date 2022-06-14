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
        static let result = "result"
        static let size = "limit"
        static let page = "page"
        static let sort = "sort"
        static let order = "order"
        static let status = "status"
        static let name = "name"
        static let jsonrpc = "jsonrpc" // check again
        static let reviewed = "reviewed"
        static let field = "field"
    }
    enum Profile {
        static let params = "params"
        static let type = "type"
        static let email = "email"
        static let phone = "phone"
        static let name = "name"
        static let birthday = "birthday"
        static let gender = "gender"
        static let stateCity = "stateCity"
        static let province = "province"
        static let street = "street"
        static let city = "city"
        static let ward = "ward"
        static let company = "isCompany"
        static let changePassword = "changePassword"
        static let currentPassword = "currentPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        
    }
    
    enum Authenticate {
        static let login = "login"
        static let password = "password"
        static let phone = "phone"
        static let name = "name"
        static let type = "type"
        static let token = "token"
        static let email = "email"
    }
    
    enum Reviews {
        static let userId = "userId"
        static let rating = "rating"
        static let message = "message"
        static let name = "name"
        static let data = "data"
        static let attachments = "attachments"
        static let text = "text"
        static let point = "point"
    }
    
    enum Order {
        static let params = "params"
        static let id = "id"
        static let order = "order"
        static let customerId = "customerId"
        static let shippingAddress = "shippingAddress"
        static let shippingAddressUnder = "shipping_address" // temp
        static let name = "name"
        static let phone = "phone"
        static let street = "street"
        
        static let lines = "lines"
        static let productId = "productId"
        static let productIdUnder = "product_id" // temp
        static let priceUnitUnder = "price_unit" // temp
        static let quantity = "quantity"
        static let priceUnit = "priceUnit"
        static let defaultCode = "defaultCode"
        static let reason = "reason"
        static let hotDealId = "hotDealId"
    }
    
    enum VNPay {
        static let orderId = "order_id"
        static let amount = "amount"
        static let orderDesc = "order_desc"
        static let language = "language"
        static let bankCode = "bank_code"
    }
    
    enum Category {
        static let parent = "parent"
    }
}
