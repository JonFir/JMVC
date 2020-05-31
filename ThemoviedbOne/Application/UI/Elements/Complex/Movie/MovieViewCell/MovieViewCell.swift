import UIKit
import AlamofireImage

class MovieViewCell: UITableViewCell {
    
    private let images = (
        placeholder: UIImage(systemName: "photo"),
        isFavorite: UIImage(systemName: "star.fill"),
        isntFavorite: UIImage(systemName: "star")
    )
    private var onFavoriteToogle: VoidClosure?
    
    @IBOutlet private var posterView: UIImageView!
    @IBOutlet private var titleView: UILabel!
    @IBOutlet private var descriptionView: UILabel!
    @IBOutlet private var favoriteButton: UIButton!

    
    @discardableResult
    func udapte(with inputData: MovieViewCellInputData) -> Self {
        if let url = inputData.posterUrl {
            posterView.af.setImage(withURL: url, placeholderImage: self.images.placeholder)
        } else {
            posterView.image = self.images.placeholder
        }
        
        titleView.text = inputData.title
        descriptionView.text = inputData.description
        let favoriteImage = inputData.isFavorite ? images.isFavorite : images.isntFavorite
        favoriteButton.setImage(favoriteImage, for: .normal)
        onFavoriteToogle = inputData.onFavoriteToogle
        
        return self
    }
    
    @IBAction func favoriteToggle() {
        onFavoriteToogle?()
    }
    
}


struct MovieViewCellInputData: Hashable {
    let id: Int
    let posterUrl: URL?
    let title: String
    let description: String
    let isFavorite: Bool
    let onSelect: VoidClosure
    let onFavoriteToogle: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isFavorite)
    }
    
    static func == (lhs: MovieViewCellInputData, rhs: MovieViewCellInputData) -> Bool {
        return lhs.id == rhs.id && lhs.isFavorite == rhs.isFavorite
    }
}
