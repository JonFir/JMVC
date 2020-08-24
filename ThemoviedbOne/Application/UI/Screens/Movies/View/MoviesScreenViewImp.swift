import UIKit
import Combine
import SnapKit

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
    
    private let containerView =  UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
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
    
    private func setupContainerView() {
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.alignment = .fill
        containerView.spacing = 0
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setup() {
        backgroundColor = .white
        setupContainerView()
        
        moviesView.onScrollAtEnd = { [weak self] in self?.events.send(.scrollAtEnd) }
        [moviesView, zeroView, errorView].forEach(containerView.addArrangedSubview)
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
