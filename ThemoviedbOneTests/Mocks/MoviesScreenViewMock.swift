import UIKit
import Combine
@testable import ThemoviedbOne


final class MoviesScreenViewMock: UIView, MoviesScreenView {
    typealias OnUpdate = (MoviesScreenViewInputData) -> Void
    
    let events = PassthroughSubject<MoviesScreenViewEvent, Never>()
    
    var onUpdate: OnUpdate?
    func udapte(with inputData: MoviesScreenViewInputData) -> Self {
        onUpdate?(inputData)
        return self
    }
    
}







































//class MoviesScreenViewMock: UIView, MoviesScreenView {
//    typealias OnUpdate = (MoviesScreenViewInputData) -> Void
//
//
//    let events = PassthroughSubject<MoviesScreenViewEvent, Never>()
//
//    var onUdapte: OnUpdate?
//    func udapte(with inputData: MoviesScreenViewInputData) -> Self {
//        onUdapte?(inputData)
//        return self
//    }
//
//}
