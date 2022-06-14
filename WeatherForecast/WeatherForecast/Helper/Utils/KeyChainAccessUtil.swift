import Foundation
import Security

class KeyChainAccess {
    let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
    let kSecClassValue = String(format: kSecClass as String)
    let kSecAttrServiceValue = String(format: kSecAttrService as String)
    let kSecValueDataValue = String(format: kSecValueData as String)
    let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
    let kSecReturnDataValue = String(format: kSecReturnData as String)
    let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
    let kSecAttrAccountValue = String(format: kSecAttrAccount as String)

    static let shared = KeyChainAccess()

    public init() { }

    func setSecretKey(identifer: String, keyData: Data) {
        let keyChainQuery = [kSecClassValue: kSecClassGenericPasswordValue,
                             kSecAttrServiceValue: identifer,
                             kSecValueDataValue: keyData] as CFDictionary
        SecItemDelete(keyChainQuery)
        SecItemAdd(keyChainQuery, nil)
        Log.d("Saved key chain successfully")
    }

    func getSecretKey(identifier: String) -> Data? {
        let keychainQuery = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: identifier,
            kSecReturnDataValue: kCFBooleanTrue!,
            kSecMatchLimitValue: kSecMatchLimitOneValue
        ] as CFDictionary
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            Log.d("Get data from key chain successfully")
            return retrievedData
        } else {
            Log.d("Failed to get data from key chain")
            return nil
        }

    }
    
    func deleteSecretKey(identifer: String, keyData: Data) {
        let keyChainQuery = [kSecClassValue: kSecClassGenericPasswordValue,
                             kSecAttrServiceValue: identifer,
                             kSecValueDataValue: keyData] as CFDictionary
        SecItemDelete(keyChainQuery)
        Log.d("Deleted key chain successfully")
    }
}
