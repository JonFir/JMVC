import UIKit
import class Alamofire.Session

#if DEBUG

final class DiScreenshotMock {
    
    fileprivate let screenFactory: ScreenFactoryScreenshotMock
    fileprivate let coordinatorFactory: CoordinatorFactoryScreenshotMock
    
    fileprivate var moviesPagerProvider: MoviesPagerProvider {
        return MoviesPagerProviderScreenshotMock()
    }
    
    fileprivate var loginProvider: LoginProvider {
        return LoginProviderScreenshotMock()
    }
    
    fileprivate var movieProvider: MovieProvider {
        return MovieProviderScreenshotMock()
    }
    
    fileprivate var loginStatusProvider: LoginStatusProvider {
        return LoginStatusProviderScreenshotMock()
    }
    
    init() {
        
        self.screenFactory = ScreenFactoryScreenshotMock()
        self.coordinatorFactory = CoordinatorFactoryScreenshotMock(screenFactory: screenFactory)
        screenFactory.di = self
    }
    
}

extension DiScreenshotMock: AppFactory {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        UIView.setAnimationsEnabled(false)
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

final class ScreenFactoryScreenshotMock: ScreenFactory {
    fileprivate weak var di: DiScreenshotMock!
    fileprivate init(){}
    
    func makeSplashScreen() -> SplashScreenVC<SplashScreenViewImpl> {
        return SplashScreenVC<SplashScreenViewImpl>(loginStatusProvider: di.loginStatusProvider)
    }
    
    func makeLoginScreen() -> LoginScreenVC<LoginScreenViewImpl> {
        return LoginScreenVC<LoginScreenViewImpl>(loginProvider: di.loginProvider)
    }
    
    func makeMoviesScreen() -> MoviesScreenVC<MoviesScreenViewImp> {
        return MoviesScreenVC<MoviesScreenViewImp>(moviesPagerProvider: di.moviesPagerProvider)
    }
    
    func makeMovieScreen(id: Movie.Id) -> MovieScreenVC<MovieScreenViewImpl> {
        return MovieScreenVC<MovieScreenViewImpl>(movieProvider: di.movieProvider, id: id)
    }
}


final class CoordinatorFactoryScreenshotMock {
    
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinatorScreenshotMock {
        return ApplicationCoordinatorScreenshotMock(router: router, screenFactory: screenFactory)
    }
    
}

#endif
