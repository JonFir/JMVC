import Foundation


extension Optional {
    
    @inlinable
    func apply(_ perform: (Wrapped) throws -> Void ) rethrows {
        guard case .some(let value) = self else { return }
        try perform(value)
    }
    
    @inlinable
    func apply(_ perform: ((Wrapped) throws -> Void)? ) rethrows {
        guard case .some(let value) = self else { return }
        try perform?(value)
    }
    
}
