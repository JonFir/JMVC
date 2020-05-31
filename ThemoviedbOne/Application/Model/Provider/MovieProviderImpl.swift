import Combine
import Foundation

protocol MovieProvider {
    
    var state: CurrentValueSubject<MovieProviderState, Never> { get }
    
    func findMovie(by id: Movie.Id)
    
}

final class MovieProviderImpl: MovieProvider {
    
    let state = CurrentValueSubject<MovieProviderState, Never>(MovieProviderState.initial)
    
    private let movieService: MovieService
    private var request: AnyCancellable?
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func findMovie(by id: Movie.Id) {
        guard !state.value.isLoadProgress else { return }
        request = movieService.movie(by: id)
            .sink(
                receiveCompletion: { [weak self] result in
                    guard let self = self, case .failure(let error) = result else { return }
                    self.state.value = self.state.value.with(error: error).with(isLoadProgress: false)
                },
                receiveValue: { [weak self] movie in
                    guard let self = self else { return }
                    self.state.value = self.state.value.with(movie: movie).with(isLoadProgress: false)
            })
    }
}

struct MovieProviderState {
    
    let movie: Movie?
    let isLoadProgress: Bool
    let error: Error?
    
    static let initial = MovieProviderState(
        movie: nil,
        isLoadProgress: false,
        error: nil
    )
    
    func with(movie: Movie?) -> Self {
        return MovieProviderState(
            movie: movie,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
    func with(isLoadProgress: Bool) -> Self {
        return MovieProviderState(
            movie: movie,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
    func with(error: Error?) -> Self {
        return MovieProviderState(
            movie: movie,
            isLoadProgress: isLoadProgress,
            error: error
        )
    }
    
}
