import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactoryImpl
    private let router: Router
    private var isAutorized = false
    
    init(router: Router, coordinatorFactory: CoordinatorFactoryImpl) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        if isAutorized {
            runMovieFlow()
        } else {
            runLoginFlow()
        }
    }
    
    private func runLoginFlow() {
        
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isAutorized = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMovieFlow() {
        let coordinator = coordinatorFactory.makeMovieCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isAutorized = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
}
