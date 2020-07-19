import Foundation
import Swinject

final class ApplicationCoordinator: BaseCoordinator {
    
    private let resolver: Resolver
    private let router: Router
    
    private var isFirstLaunch = true
    private var isLogin = false
    
    init(router: Router, resolver: Resolver) {
        self.router = router
        self.resolver = resolver
    }
    
    override func start() {
        if isFirstLaunch {
            runStartFlow()
            isFirstLaunch = false
            return
        }
        
        if isLogin {
            runMovieFlow()
        } else {
            runLoginFlow()
        }
    }
    
    private func runStartFlow() {
        let coordinator = resolver.resolve(StartCoordinator.self, argument: router)!
        coordinator.finishFlow = { [weak self, weak coordinator] isLogin in
            self?.isLogin = isLogin
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runLoginFlow() {
        
        let coordinator = resolver.resolve(LoginCoordinator.self, argument: router)!
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMovieFlow() {
        let coordinator = resolver.resolve(MoviesCoordinator.self, argument: router)!
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
}
