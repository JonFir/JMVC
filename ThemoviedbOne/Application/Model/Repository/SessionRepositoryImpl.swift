import Foundation

protocol SessionRepository: AnyObject {
    var sessionID: String? { get set }
}

class SessionRepositoryImpl: SessionRepository {
    private let keychainWrapper: KeychainWrapper
    
    init(keychainWrapper: KeychainWrapper) {
        self.keychainWrapper = keychainWrapper
    }
    
    var sessionID: String? {
        get {
            keychainWrapper.string(forKey: SessionRepositoryKeys.sessionID.rawValue, withAccessibility: nil)
        }
        set {
            if let newValue = newValue {
                keychainWrapper.set(newValue, forKey: SessionRepositoryKeys.sessionID.rawValue, withAccessibility: nil)
            } else {
                keychainWrapper.removeObject(forKey: SessionRepositoryKeys.sessionID.rawValue)
            }
        }
    }
}


private enum SessionRepositoryKeys: String {
    case sessionID
}
