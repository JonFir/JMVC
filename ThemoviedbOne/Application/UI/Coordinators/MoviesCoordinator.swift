import Foundation

final class MoviesCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showMovies()
    }
    
    private func showMovies() {
        let moviesScreen = screenFactory.makeMoviesScreen()
        moviesScreen.onSelecMovie = { [weak self] in self?.showMovie(id: $0) }
        router.setRootModule(moviesScreen, hideBar: false)
    }
    
    private func showMovie(id: Movie.Id) {
        let moviesScreen = screenFactory.makeMovieScreen(id: id)
        router.push(moviesScreen)
    }
}
