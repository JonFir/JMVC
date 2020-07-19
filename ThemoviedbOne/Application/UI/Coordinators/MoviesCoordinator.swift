import UIKit
import Swinject

final class MoviesCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let resolver: Resolver
    private let router: Router
    
    init(router: Router, resolver: Resolver) {
        self.resolver = resolver
        self.router = router
    }
    
    override func start() {
        showMovies()
    }
    
    private func showMovies() {
        let moviesScreen = resolver.resolve(MoviesScreenVC<MoviesScreenViewImp>.self)!
        moviesScreen.onSelectMovie = { [weak self] in self?.showMovie(id: $0) }
        moviesScreen.onShowFavoriteAlert = { [weak router] data in
            let alert = UIAlertController(inputData: data)
            router?.present(alert)
        }
        router.setRootModule(moviesScreen, hideBar: false)
    }
    
    private func showMovie(id: Movie.Id) {
        let moviesScreen = resolver.resolve(MovieScreenVC<MovieScreenViewImpl>.self, argument: id)!
        router.push(moviesScreen)
    }
    
}
