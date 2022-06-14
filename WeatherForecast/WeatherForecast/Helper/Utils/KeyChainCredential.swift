import Foundation

struct KeychainConfiguration {
    static let serviceName = "AuthBiometric"
    static let accessGroup: String? = nil
}

struct KeyChainCredential {
    enum KeychainError: Error {
        case noCrendential
        case unexpectedCrendentialData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    // MARK: Properties
    
    let service: String
    
    private(set) var account: String
    
    let accessGroup: String?
    
    // MARK: Intialization
    
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: Keychain access
    
    func readCredential() throws -> String {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeyChainCredential.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noCrendential }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the credential string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let crendetialData = existingItem[kSecValueData as String] as? Data,
              let credential = String(data: crendetialData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedCrendentialData
        }
        
        return credential
    }
    
    func saveCredential(_ crendetial: String) throws {
        // Encode the crendetial into an Data object.
        let encodedcrendetial = crendetial.data(using: String.Encoding.utf8)!
        
        do {
            // Check for an existing item in the keychain.
            try _ = readCredential()
            
            // Update the existing item with the new crendetial.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedcrendetial as AnyObject?
            
            let query = KeyChainCredential.keychainQuery(withService: service,
                                                         account: account,
                                                         accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        } catch KeychainError.noCrendential {
            /*
             No credential was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeyChainCredential.keychainQuery(withService: service,
                                                           account: account,
                                                           accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedcrendetial as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeyChainCredential.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound
        else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func credentialItems(forService service: String, accessGroup: String? = nil) throws -> [KeyChainCredential] {
        // Build a query for all items that match the service and access group.
        var query = KeyChainCredential.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse
        
        // Fetch matching items from the keychain.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String: AnyObject]] else { throw KeychainError.unexpectedItemData }
        
        // Create a `KeyChainCredential` for each dictionary in the query result.
        var credentailItems = [KeyChainCredential]()
        for result in resultData {
            guard let account  = result[kSecAttrAccount as String] as? String
                else { throw KeychainError.unexpectedItemData }
            
            let credentailItem = KeyChainCredential(service: service, account: account, accessGroup: accessGroup)
            credentailItems.append(credentailItem)
        }
        return credentailItems
    }

    // MARK: Convenience
    
    private static func keychainQuery(withService service: String,
                                      account: String? = nil,
                                      accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
