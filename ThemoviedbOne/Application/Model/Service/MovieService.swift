import Combine
import Foundation

protocol MovieService {
    
    func movies(at page: Int) -> AnyPublisher<[Movie], Error>
    
    func movie(by id: Int) -> AnyPublisher<Movie, Error>
    
}

final class MovieServiceImpl: MovieService {
    
    private let configuration: Configuration
    private let movieApiClient: MovieApiClient
    private var request: AnyCancellable?
    
    init(
        configuration: Configuration,
        movieApiClient: MovieApiClient
    ) {
        self.configuration = configuration
        self.movieApiClient = movieApiClient
    }
    
    func movies(at page: Int) -> AnyPublisher<[Movie], Error> {
        return movieApiClient.movieList(page: page)
            .map { [configuration] result in
                result.results.map { $0.with(imageUrl: configuration.imageUrl) }
        }
        .eraseToAnyPublisher()
    }
    
    func movie(by id: Int) -> AnyPublisher<Movie, Error> {
        return movieApiClient.movie(id: id)
            .map { [configuration] in $0.with(imageUrl: configuration.imageUrl) }
            .eraseToAnyPublisher()
    }
    
}
