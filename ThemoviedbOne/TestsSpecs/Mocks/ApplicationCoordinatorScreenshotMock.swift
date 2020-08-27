import UIKit

#if DEBUG

final class ApplicationCoordinatorScreenshotMock: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    func start() {
        switch TestConfiguration.shared.startFlow {
        case .splash:
            showSplash()
        case .loginWrongLogin, .login, .loginNotInternet:
            showLogin()
        }
    }
    
    private func showSplash() {
        let splashScreen = screenFactory.makeSplashScreen()
        router.setRootModule(splashScreen, hideBar: true)
    }
    
    private func showLogin() {
        let loginScreen = screenFactory.makeLoginScreen()
        loginScreen.loadViewIfNeeded()
        
        (loginScreen.view.viewWithTag(1) as! UITextField).text = "TestTest"
        (loginScreen.view.viewWithTag(1) as! UITextField).sendActions(for: .editingChanged)
        (loginScreen.view.viewWithTag(2) as! UITextField).text = "TestTest"
        (loginScreen.view.viewWithTag(2) as! UITextField).sendActions(for: .editingChanged)
        router.setRootModule(loginScreen, hideBar: true)
    }
    
}

#endif
