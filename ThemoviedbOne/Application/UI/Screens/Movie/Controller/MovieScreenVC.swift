import UIKit
import Combine

final class MovieScreenVC<View: MovieScreenView>: BaseViewController<View> {
    
    private let movieProvider: MovieProvider
    private let id: Movie.Id
    
    private var cancalables = Set<AnyCancellable>()
    
    init(movieProvider: MovieProvider, id: Movie.Id) {
        self.movieProvider = movieProvider
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieProvider.findMovie(by: id)
        movieProvider.state
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.onStateChange($0) }
            .store(in: &cancalables)
        
        title = "Loading"
    }
    
    private func onStateChange(_ state: MovieProviderState) {
        let movie = makeMovieScreenViewInputData(form: state)
        title = state.movie?.title ?? " - "
        rootView.udapte(with: movie)
    }
    
    private func makeMovieScreenViewInputData(form state: MovieProviderState) -> MovieScreenViewInputData {
        let error = state.error.map {_ in ErrorInputData.applicationError }
        let zeroError: ErrorInputData?
        let errorMessage: ErrorInputData?
        
        if state.movie == nil {
            zeroError = error
            errorMessage = nil
        } else {
            zeroError = nil
            errorMessage = error
        }
        
        return MovieScreenViewInputData(
            movie: state.movie.map(makeMovie),
            zeroError: zeroError,
            errorMessage: errorMessage
        )
    }
    
    private func makeMovie(from movie: Movie) -> MovieScreenViewInputData.Movie {
        return MovieScreenViewInputData.Movie(
            id: movie.id,
            posterUrl: URL(string: movie.posterPath),
            date: movie.releaseDate,
            description: movie.overview
        )
    }
    
}
