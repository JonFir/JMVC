import UIKit
import AlamofireImage

class MovieViewCell: UITableViewCell {
    
    private let images = (
        placeholder: UIImage(systemName: "photo"),
        isFavorite: UIImage(systemName: "star.fill"),
        isntFavorite: UIImage(systemName: "star")
    )
    private var onFavoriteToggle: VoidClosure?
    
    private let posterView =  UIImageView()
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    @objc private let favoriteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    @discardableResult
    func update(with inputData: MovieViewCellInputData) -> Self {
        if let url = inputData.posterUrl {
            posterView.af.setImage(withURL: url, placeholderImage: self.images.placeholder)
        } else {
            posterView.image = self.images.placeholder
        }
        
        titleView.text = inputData.title
        descriptionView.text = inputData.description
        let favoriteImage = inputData.isFavorite ? images.isFavorite : images.isntFavorite
        favoriteButton.setImage(favoriteImage, for: .normal)
        onFavoriteToggle = inputData.onFavoriteToggle
        
        return self
    }
    
    @objc private func favoriteToggle() {
        onFavoriteToggle?()
    }
    
    private func setupPosterView() {
        posterView.image = UIImage(systemName: "photo")
        posterView.contentMode = .scaleAspectFit
        posterView.clipsToBounds = true
        
        contentView.addSubview(posterView)
        
        posterView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.centerY.equalToSuperview()
        }
    }
    
    private func setupTitleView() {
        titleView.font = .systemFont(ofSize: 15)
        titleView.numberOfLines = .zero
        
        contentView.addSubview(titleView)
        
        titleView.snp.makeConstraints {
            $0.leading.equalTo(posterView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-66)
            $0.top.equalTo(posterView)
        }
    }
    
    private func setupDescriptionView() {
        descriptionView.textColor = .systemGray2
        descriptionView.font = .systemFont(ofSize: 13)
        descriptionView.numberOfLines = .zero
        
        contentView.addSubview(descriptionView)
        
        descriptionView.snp.makeConstraints {
            $0.leading.equalTo(posterView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-66)
            $0.top.greaterThanOrEqualTo(titleView.snp.bottom).offset(10)
            $0.bottom.equalTo(posterView)
        }
    }
    
    private func setupFavoriteButton() {
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteToggle), for: .touchUpInside)
        
        addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setup() {
        setupPosterView()
        setupTitleView()
        setupDescriptionView()
        setupFavoriteButton()
    }
    
}


struct MovieViewCellInputData: Hashable {
    let id: Int
    let posterUrl: URL?
    let title: String
    let description: String
    let isFavorite: Bool
    let onSelect: VoidClosure
    let onFavoriteToggle: VoidClosure
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isFavorite)
    }
    
    static func == (lhs: MovieViewCellInputData, rhs: MovieViewCellInputData) -> Bool {
        return lhs.id == rhs.id && lhs.isFavorite == rhs.isFavorite
    }
}
