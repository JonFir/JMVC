import Foundation
import Combine
@testable import ThemoviedbOne


final class MoviesPagerProviderMock: MoviesPagerProvider {
    
    let state = CurrentValueSubject<MoviesPagerProviderState, Never>(MoviesPagerProviderState.initial)
    
    var onNextPage: VoidClosure?
    
    func nextPage() {
        onNextPage?()
    }
    
}




































//final class MoviesPagerProviderMock: MoviesPagerProvider {
//
//    let state = CurrentValueSubject<MoviesPagerProviderState, Never>(MoviesPagerProviderState.initial)
//
//    private(set) var nextPage_call_times_count = 0
//    func nextPage() {
//        nextPage_call_times_count += 1
//    }
//
//}
