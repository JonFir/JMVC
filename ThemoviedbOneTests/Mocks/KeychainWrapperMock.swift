import Foundation
@testable import ThemoviedbOne

final class KeychainWrapperMock: KeychainWrapper {
    
    var values: [AnyHashable: Any] = [:]
    
    func string(
        forKey key: String,
        withAccessibility accessibility: KeychainItemAccessibility?
    ) -> String? {
        return values[key] as? String
    }
    
    func set(
        _ value: String,
        forKey key: String,
        withAccessibility accessibility: KeychainItemAccessibility?
    ) -> Bool {
        values[key] = value
        return true
    }
    
    func removeObject(
        forKey key: String,
        withAccessibility accessibility: KeychainItemAccessibility?
    ) -> Bool {
        let isContainKey = values[key] != nil
        values[key] = nil
        return isContainKey
    }
    
}
