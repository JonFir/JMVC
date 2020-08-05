import Foundation
import Swinject


class CoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ApplicationCoordinator.self) { (_, router: RouterImp) in
            ApplicationCoordinator(router: router, resolver: assembler.resolver)
        }
        container.register(LoginCoordinator.self) { _, router in
            LoginCoordinator(router: router, resolver: assembler.resolver)
        }
        container.register(MoviesCoordinator.self) {  _, router in
            MoviesCoordinator(router: router, resolver: assembler.resolver)
        }
        container.register(StartCoordinator.self) { _, router in
            StartCoordinator(router: router, resolver: assembler.resolver)
        }
        
    }
    
}
