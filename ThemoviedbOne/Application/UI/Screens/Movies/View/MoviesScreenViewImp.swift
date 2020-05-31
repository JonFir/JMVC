import UIKit
import Combine

protocol MoviesScreenView: UIView {
    
    var events: PassthroughSubject<MoviesScreenViewEvent, Never> { get }
    
    @discardableResult
    func udapte(with inputData: MoviesScreenViewInputData) -> Self
    
}

final class MoviesScreenViewImp: UIView, MoviesScreenView {
    
    let events = PassthroughSubject<MoviesScreenViewEvent, Never>()
    
    private let moviesView = MoviesView.loadFromNib()
    private let zeroView = ZeroView.loadFromNib()
    private let errorView = ErrorView.loadFromNib()
    
    @IBOutlet private var containerView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviesView.onScrollAtEnd = { [weak self] in self?.events.send(.scrollAtEnd) }
        [moviesView, zeroView, errorView].forEach(containerView.addArrangedSubview)
    }
    
    @discardableResult
    func udapte(with inputData: MoviesScreenViewInputData) -> Self {
        moviesView.update(cellData: inputData.movies)
        
        if let zeroError = inputData.zeroError {
            zeroView.update(with: zeroError)
            zeroView.show()
            moviesView.hide()
        } else {
            zeroView.hide()
            moviesView.show()
        }
        
        if let errorMessage = inputData.errorMessage {
            errorView.update(with: errorMessage)
            errorView.show()
        } else {
            errorView.hide()
        }
        
        return self
    }
    
}


struct MoviesScreenViewInputData {
    let movies: [MovieViewCellInputData]
    let zeroError: ErrorInputData?
    let errorMessage: ErrorInputData?
}

enum MoviesScreenViewEvent {
    case scrollAtEnd
}

#if DEBUG

import SwiftUI

struct MoviesScreenViewImp_Previews: PreviewProvider {
    static let data = MoviesScreenViewInputData(
        movies: [],
        zeroError: nil,
        errorMessage: ErrorInputData.applicationError
    )
    static var previews: some View {
        PreviewContainer(view: MoviesScreenViewImp.loadFromNib().udapte(with: Self.data))
    }
}

#endif
