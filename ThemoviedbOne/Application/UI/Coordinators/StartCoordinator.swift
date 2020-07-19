import Foundation
import Swinject

final class StartCoordinator: BaseCoordinator {
    
    var finishFlow: BoolClosure?
    
    private let resolver: Resolver
    private let router: Router
    
    init(router: Router, resolver: Resolver) {
        self.resolver = resolver
        self.router = router
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {
        let splashScreen = resolver.resolve(SplashScreenVC<SplashScreenViewImpl>.self)!
        splashScreen.onCheck = { [weak self] isLogin in
            self?.finishFlow?(isLogin)
        }
        
        router.setRootModule(splashScreen, hideBar: true)
    }
}
