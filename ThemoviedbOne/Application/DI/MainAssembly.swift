import Foundation
import Swinject
import class Alamofire.Session

let assembler = Assembler(
    [
        MainAssembly(),
        ScreenAssembly(),
        CoordinatorAssembly(),
    ]
)

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(Configuration.self) { _ in ProductionConfiguration() }
        container.register(Session.self) { _ in Session.default }
        container.register(KeychainWrapper.self) { _ in KeychainWrapperImpl.standard }
        container.register(RequestBuilder.self) { RequestBuilderImpl(configuration: $0.resolve(Configuration.self)!) }
        container.register(SessionRepository.self) {
            SessionRepositoryImpl(keychainWrapper: $0.resolve(KeychainWrapper.self)!)
        }
        container.register(JSONDecoder.self) { _ in JSONDecoder.makeBaseDecoder() }
        container.register(ApiClient.self) {
            ApiClient(
                requestBuilder: $0.resolve(RequestBuilder.self)!,
                session: $0.resolve(Session.self)!,
                decoder: $0.resolve(JSONDecoder.self)!
            )
        }
        container.register(AppFactory.self) { _ in  AppFactoryImpl(resolver: assembler.resolver) }
        
    }
    
}
