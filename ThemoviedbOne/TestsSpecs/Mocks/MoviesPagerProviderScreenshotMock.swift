import Foundation
import Combine

#if DEBUG

final class MoviesPagerProviderScreenshotMock: MoviesPagerProvider {
    
    let state = CurrentValueSubject<MoviesPagerProviderState, Never>(MoviesPagerProviderState.initial)
    
    func nextPage() {
        
    }
    
}

#endif
