import Foundation
import Swinject

final class LoginCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let resolver: Resolver
    private let router: Router
    
    init(router: Router, resolver: Resolver) {
        self.router = router
        self.resolver = resolver
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let loginScreen = resolver.resolve(LoginScreenVC<LoginScreenViewImpl>.self)!
        loginScreen.onLogin = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(loginScreen, hideBar: true)
    }
}
