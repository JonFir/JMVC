import Foundation
import Swinject

class ScreenAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SplashScreenVC<SplashScreenViewImpl>.self) {
            SplashScreenVC<SplashScreenViewImpl>(loginStatusProvider: $0.resolve(LoginStatusProvider.self)!)
        }
        container.register(LoginScreenVC<LoginScreenViewImpl>.self) {
            LoginScreenVC<LoginScreenViewImpl>(loginProvider: $0.resolve(LoginProvider.self)!)
        }
        container.register(MoviesScreenVC<MoviesScreenViewImp>.self) {
            MoviesScreenVC<MoviesScreenViewImp>(moviesPagerProvider: $0.resolve(MoviesPagerProvider.self)!)
        }
        container.register(MovieScreenVC<MovieScreenViewImpl>.self) { r, id in
            MovieScreenVC<MovieScreenViewImpl>(movieProvider: r.resolve(MovieProvider.self)!, id: id)
        }
        
    }
    
}
