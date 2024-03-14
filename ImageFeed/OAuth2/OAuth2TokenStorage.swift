import Foundation

class OAuth2TokenStorage {
    let userDefaults = UserDefaults.standard
    let tokenSave = "token"
    
    var token: String? {
        get {
            return userDefaults.string(forKey: tokenSave)
        }
        set {
            userDefaults.set(newValue, forKey: tokenSave)
        }
    }
}
