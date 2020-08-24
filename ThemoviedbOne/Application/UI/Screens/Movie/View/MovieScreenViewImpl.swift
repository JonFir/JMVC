import UIKit
import SnapKit

protocol MovieScreenView: UIView {
    
    @discardableResult
    func udapte(with inputData: MovieScreenViewInputData) -> Self
    
}

final class MovieScreenViewImpl: UIView, MovieScreenView {
    
    private let placeholderImage = UIImage(systemName: "photo")
    
    private let zeroView = ZeroView.loadFromNib()
    private let errorView = ErrorView.loadFromNib()
    
    private let scrollView = UIScrollView()
    private let stackContainer = UIStackView()
    private let posterView = UIImageView()
    private let infoContainerView = UIStackView()
    private let dateView = UILabel()
    private let descriptionView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [zeroView, errorView].forEach(addSubviewWithSameSize)
    }
    
    @discardableResult
    func udapte(with inputData: MovieScreenViewInputData) -> Self {
        
        inputData.movie.apply(update)
        
        if let zeroError = inputData.zeroError {
            zeroView.update(with: zeroError)
            zeroView.show()
        } else {
            zeroView.hide()
        }
        
        if let errorMessage = inputData.errorMessage {
            errorView.update(with: errorMessage)
            errorView.show()
        } else {
            errorView.hide()
        }
        
        return self
    }
    
    private func update(with movie: MovieScreenViewInputData.Movie) {
        if let url = movie.posterUrl {
            posterView.af.setImage(withURL: url, placeholderImage: placeholderImage)
        } else {
            posterView.image = placeholderImage
        }
        
        dateView.text = movie.date
        descriptionView.text = movie.description
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupStackContainer() {
        stackContainer.axis = .vertical
        stackContainer.distribution = .fill
        stackContainer.alignment = .fill
        stackContainer.spacing = 20
        
        scrollView.addSubview(stackContainer)
        
        stackContainer.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    
    private func setupPosterView() {
        posterView.backgroundColor = .black
        posterView.contentMode = .scaleAspectFit
        posterView.clipsToBounds = true
        
        stackContainer.addArrangedSubview(posterView)
        
        posterView.snp.makeConstraints {
            $0.width.equalTo(posterView.snp.height)
        }
    }
    
    private func setupInfoContainerView() {
        infoContainerView.axis = .vertical
        infoContainerView.distribution = .fill
        infoContainerView.alignment = .fill
        infoContainerView.spacing = 20
        infoContainerView.isLayoutMarginsRelativeArrangement = true
        infoContainerView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 34,
            trailing: 16
        )
        
        stackContainer.addArrangedSubview(infoContainerView)
    }
    
    private func setupDateView() {
        dateView.textColor = .systemGray2
        dateView.font = .preferredFont(forTextStyle: .subheadline)
        
        infoContainerView.addArrangedSubview(dateView)
    }
    
    private func setupDescriptionView() {
        descriptionView.font = .preferredFont(forTextStyle: .body)
        descriptionView.numberOfLines = .zero
        
        infoContainerView.addArrangedSubview(descriptionView)
    }
    
    private func setup() {
        backgroundColor = .white
        setupScrollView()
        setupStackContainer()
        setupPosterView()
        setupInfoContainerView()
        setupDateView()
        setupDescriptionView()
    }
}

struct MovieScreenViewInputData {
    
    struct Movie {
        let id: Int
        let posterUrl: URL?
        let date: String
        let description: String
    }
    
    let movie: Movie?
    let zeroError: ErrorInputData?
    let errorMessage: ErrorInputData?
}

#if DEBUG

import SwiftUI

struct MovieScreenViewImpl_Previews: PreviewProvider {
    static let data = MovieScreenViewInputData(
        movie: MovieScreenViewInputData.Movie(
            id: 1,
            posterUrl: URL(string: "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")!,
            date: "020-05-22",
            description: "In Scooby-Doo’s greatest adventure yet, see the never-before told story of how lifelong friends Scooby and Shaggy first met and how they joined forces with young detectives Fred, Velma, and Daphne to form the famous Mystery Inc. Now, with hundreds of cases solved, Scooby and the gang face their biggest, toughest mystery ever: an evil plot to unleash the ghost dog Cerberus upon the world. As they race to stop this global “dogpocalypse,” the gang discovers that Scooby has a secret legacy and an epic destiny greater than anyone ever imagined."
        ),
        zeroError: nil,
        errorMessage: nil
    )
    static var previews: some View {
        PreviewContainer(view: MovieScreenViewImpl.loadFromNib().udapte(with: Self.data))
    }
}

#endif
