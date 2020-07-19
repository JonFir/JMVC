import UIKit
import Swinject

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

final class AppFactoryImpl: AppFactory {
    
    private let resolver: Resolver
    
    init(resolver: Resolver) { self.resolver = resolver }
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let coordinator = resolver.resolve(ApplicationCoordinator.self, argument: router)!
        window.rootViewController = rootVC
        return (window, coordinator)
    }
    
}