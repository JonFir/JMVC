import Foundation

final class LoginCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let loginScreen = screenFactory.makeLoginScreen()
        loginScreen.onLogin = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(loginScreen, hideBar: true)
    }
}
