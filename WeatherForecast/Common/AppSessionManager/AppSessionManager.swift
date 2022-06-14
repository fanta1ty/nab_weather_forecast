import Foundation
import UIKit

class AppSessionManager {
    
    public static var shared = AppSessionManager()
    
    var idToken: String = ""
    var authorizationToken: String = ""
        
    public init() {
        
    }
    
    func getAuthorizationToken() -> String {
        return authorizationToken.replacingOccurrences(of: "Optional(", with: "")
    }
}
