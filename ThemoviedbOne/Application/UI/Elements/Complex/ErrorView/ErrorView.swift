import UIKit

final class ErrorView: UIView {
    private var onTryAgain: VoidClosure?
    
    private let stackContainer = UIStackView()
    private let messageLabel = UILabel()
    private let tryAgainButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    @discardableResult
    func update(with data: ErrorInputData) -> Self {
        messageLabel.text = String(data.emoji) + " " + data.message
        onTryAgain = data.onTryAgain
        tryAgainButton.isHidden = data.onTryAgain == nil
        
        return self
    }
    
    @objc private func tryAgainTapped() {
        onTryAgain?()
    }
    
    private func setupStackContainer() {
        stackContainer.axis = .vertical
        stackContainer.distribution = .fill
        stackContainer.alignment = .fill
        stackContainer.spacing = 0
        stackContainer.isLayoutMarginsRelativeArrangement = true
        stackContainer.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 34,
            trailing: 16
        )
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundView.addSubview(stackContainer)
        stackContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupMessageLabel() {
        messageLabel.textColor = .red
        messageLabel.font = .preferredFont(forTextStyle: .callout)
        
        stackContainer.addArrangedSubview(messageLabel)
    }
    
    private func setupTryAgainButton() {
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
        
        stackContainer.addArrangedSubview(tryAgainButton)
    }
    
    private func setup() {
        backgroundColor = .clear
        
        setupStackContainer()
        setupMessageLabel()
        setupTryAgainButton()
    }
    
}
