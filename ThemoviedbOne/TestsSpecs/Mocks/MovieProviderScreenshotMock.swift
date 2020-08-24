import Foundation
import Combine

#if DEBUG

final class MovieProviderScreenshotMock: MovieProvider {
    let state = CurrentValueSubject<MovieProviderState, Never>(MovieProviderState.initial)
    
    func findMovie(by id: Movie.Id) {
        
    }
    
}

#endif
