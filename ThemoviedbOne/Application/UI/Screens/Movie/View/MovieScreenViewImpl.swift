import UIKit

protocol MovieScreenView: UIView {
    
    @discardableResult
    func udapte(with inputData: MovieScreenViewInputData) -> Self
    
}

final class MovieScreenViewImpl: UIView, MovieScreenView {
    
    private let placeholderImage = UIImage(systemName: "photo")
    
    private let zeroView = ZeroView.loadFromNib()
    private let errorView = ErrorView.loadFromNib()
    
    @IBOutlet private var posterView: UIImageView!
    @IBOutlet private var dateView: UILabel!
    @IBOutlet private var descriptionView: UILabel!
    
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
