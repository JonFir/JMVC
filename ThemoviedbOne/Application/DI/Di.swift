import UIKit
import class Alamofire.Session

final class Di {
    
    fileprivate let configuration: Configuration
    fileprivate let session: Session
    
    fileprivate let keychainWrapper: KeychainWrapperImpl
    
    
    fileprivate let requestBuilder: RequestBuilderImpl
    fileprivate let sessionRepository: SessionRepositoryImpl
    fileprivate let apiClient: ApiClient
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    fileprivate var authenticatorService: AuthenticatorServiceImpl
    
    fileprivate var movieService: MovieServiceImpl {
        return MovieServiceImpl(configuration: configuration, movieApiClient: apiClient)
    }
    
    fileprivate var moviesPagerProvider: MoviesPagerProviderImpl {
        return MoviesPagerProviderImpl(movieService: movieService)
    }
    
    fileprivate var loginProvider: LoginProviderImpl {
        return LoginProviderImpl(authenticator: authenticatorService)
    }
    
    fileprivate var movieProvider: MovieProviderImpl {
        return MovieProviderImpl(movieService: movieService)
    }
    
    fileprivate var loginStatusProvider: LoginStatusProviderImpl {
        return LoginStatusProviderImpl(authenticatorService: authenticatorService)
    }
    
    init() {
        configuration = ProductionConfiguration()
        session = Session.default
        keychainWrapper = KeychainWrapperImpl.standard
        requestBuilder = RequestBuilderImpl(configuration: configuration)
        sessionRepository = SessionRepositoryImpl(keychainWrapper: keychainWrapper)
        apiClient = ApiClient(requestBuilder: requestBuilder, session: session)
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        authenticatorService = AuthenticatorServiceImpl(sessionRepository: sessionRepository, accountApiClient: apiClient)
        
        screenFactory.di = self
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

protocol ScreenFactory {
    
    func makeSplashScreen() -> SplashScreenVC<SplashScreenViewImpl>
    func makeLoginScreen() -> LoginScreenVC<LoginScreenViewImpl>
    func makeMoviesScreen() -> MoviesScreenVC<MoviesScreenViewImp>
    func makeMovieScreen(id: Movie.Id) -> MovieScreenVC<MovieScreenViewImpl>
    
}

final class ScreenFactoryImpl: ScreenFactory {
    fileprivate weak var di: Di!
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

protocol CoordinatorFactory {
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    
    func makeMovieCoordinator(router: Router) -> MoviesCoordinator
    
    func makeStartCoordinator(router: Router) -> StartCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMovieCoordinator(router: Router) -> MoviesCoordinator {
        return MoviesCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeStartCoordinator(router: Router) -> StartCoordinator {
        return StartCoordinator(router: router, screenFactory: screenFactory)
    }
}


