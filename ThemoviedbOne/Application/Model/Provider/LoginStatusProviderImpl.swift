import Foundation

protocol LoginStatusProvider {
    var isLogin: Bool { get }
}

final class LoginStatusProviderImpl: LoginStatusProvider {
    
    private let authenticatorService: AuthenticatorService
    
    init(authenticatorService: AuthenticatorService) {
        self.authenticatorService = authenticatorService
    }
    
    var isLogin: Bool { authenticatorService.isLogin }
    
}
