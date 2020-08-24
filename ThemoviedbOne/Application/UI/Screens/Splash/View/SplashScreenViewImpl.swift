import UIKit
import SnapKit

protocol SplashScreenView: UIView {}

final class SplashScreenViewImpl: UIView, SplashScreenView {
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        imageView.image = UIImage(systemName: "clock")
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.center.equalToSuperview()
        }
    }
}
