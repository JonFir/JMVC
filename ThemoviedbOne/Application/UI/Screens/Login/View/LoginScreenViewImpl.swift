import UIKit
import Combine
import SnapKit

protocol LoginScreenView: UIView {
    
    var events: PassthroughSubject<LoginScreenViewEvent, Never> { get }
    
    @discardableResult
    func udapte(with state: LoginScreenViewInputData) -> Self
}

final class LoginScreenViewImpl: UIView, LoginScreenView {

    let events = PassthroughSubject<LoginScreenViewEvent, Never>()
    
    private var outputData: LoginScreenViewOuptutData? {
        return execute(
            LoginScreenViewOuptutData.init(login:password:),
            with: loginInput.text,
            passwordInput.text
        )
    }
    
    private let stackContainer = UIStackView()
    private let loginInput = UITextField()
    private let passwordInput = UITextField()
    private let authButton = UIButton(type: .system)
    private let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    @discardableResult
    func udapte(with inputData: LoginScreenViewInputData) -> Self {
        authButton.isEnabled = inputData.isCanSubmit
        errorLabel.isHidden = inputData.errorMessage == nil
        errorLabel.text = inputData.errorMessage ?? ""
        return self
    }
    
    @objc private func auth() {
        events.send(.authButtonPressed)
    }
    
    @objc private func formDidChange() {
        outputData.map(LoginScreenViewEvent.formDidChange).apply(events.send)
    }
    
    private func setupStackContainer() {
        stackContainer.axis = .vertical
        stackContainer.distribution = .fill
        stackContainer.alignment = .fill
        stackContainer.spacing = 20
        
        let topSpacer = UILayoutGuide()
        addLayoutGuide(topSpacer)
        topSpacer.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        addSubview(stackContainer)
        stackContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(topSpacer.snp.bottom)
        }
    }
    
    private func setupLoginInput() {
        loginInput.placeholder = "Login"
        loginInput.borderStyle = .roundedRect
        loginInput.addTarget(self, action: #selector(formDidChange), for: .editingChanged)
        
        stackContainer.addArrangedSubview(loginInput)
    }
    
    private func setupPasswordInput() {
        passwordInput.placeholder = "Password"
        passwordInput.borderStyle = .roundedRect
        passwordInput.isSecureTextEntry = true
        passwordInput.addTarget(self, action: #selector(formDidChange), for: .editingChanged)
        
        stackContainer.addArrangedSubview(passwordInput)
    }
    
    private func setupAuthButton() {
        authButton.setTitle("Auth", for: .normal)
        authButton.addTarget(self, action: #selector(auth), for: .touchUpInside)
        
        stackContainer.addArrangedSubview(authButton)
    }
    
    private func setupErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.numberOfLines = .zero
        stackContainer.addArrangedSubview(errorLabel)
    }
    
    private func setup() {
        backgroundColor = .white
        setupStackContainer()
        setupLoginInput()
        setupPasswordInput()
        setupAuthButton()
        setupErrorLabel()
    }
    
}

struct LoginScreenViewInputData {
    let isCanSubmit: Bool
    let errorMessage: String?
}

struct LoginScreenViewOuptutData {
    let login: String
    let password: String
}

enum LoginScreenViewEvent {
    case formDidChange(LoginScreenViewOuptutData)
    case authButtonPressed
}
