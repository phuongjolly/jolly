import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    // Store string securely in Keychain
    func storeToken(_ token: String, forKey key: String) {
        let data = token.data(using: .utf8)!
        
        // Create query
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        
        // Delete any existing data for the key
        SecItemDelete(query as CFDictionary)
        
        // Add new data to the Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Error storing token in Keychain: \(status)")
        }
    }
    
    // Retrieve string from Keychain
    func retrieveToken(forKey key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let data = result as? Data else {
            print("Error retrieving token from Keychain: \(status)")
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    // Delete token from Keychain
    func deleteToken(forKey key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("Error deleting token from Keychain: \(status)")
        }
    }
}
