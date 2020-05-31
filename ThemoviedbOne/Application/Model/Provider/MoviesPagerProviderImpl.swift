import Combine
import Foundation

protocol MoviesPagerProvider {
    var state: CurrentValueSubject<MoviesPagerProviderState, Never> { get }
    func nextPage()
}

final class MoviesPagerProviderImpl: MoviesPagerProvider {
    
    let state = CurrentValueSubject<MoviesPagerProviderState, Never>(MoviesPagerProviderState.initial)
    
    private let movieService: MovieService
    private var request: AnyCancellable?
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func nextPage() {
        guard !state.value.isLoadProgress else { return }
        request = movieService.movies(at: state.value.nextPage)
            .sink(
                receiveCompletion: { [weak self] result in
                    guard let self = self, case .failure(let error) = result else { return }
                    self.state.value = self.state.value.with(error: error).with(isLoadProgress: false)
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    self.state.value = self.state.value
                        .incremetPage()
                        .with(error: nil)
                        .with(isLoadProgress: false)
                        .appendMovies(movies: movies)
            })
    }
}

struct MoviesPagerProviderState {
    
    let movies: [Movie]
    let nextPage: Int
    let isLoadProgress: Bool
    let error: Error?
    
    static let initial = MoviesPagerProviderState(
        movies: [],
        nextPage: 1,
        isLoadProgress: false,
        error: nil
    )
    
    func appendMovies(movies: [Movie]) -> Self {
        return MoviesPagerProviderState(
            movies: self.movies + movies,
            nextPage: nextPage,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
    func incremetPage() -> Self {
        return MoviesPagerProviderState(
            movies: movies,
            nextPage: nextPage + 1,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
    func with(isLoadProgress: Bool) -> Self {
        return MoviesPagerProviderState(
            movies: movies,
            nextPage: nextPage,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
    func with(error: Error?) -> Self {
        return MoviesPagerProviderState(
            movies: movies,
            nextPage: nextPage,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
}
