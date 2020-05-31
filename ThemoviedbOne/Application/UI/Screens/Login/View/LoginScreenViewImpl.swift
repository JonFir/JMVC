import UIKit
import Combine

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
    
    @IBOutlet private var loginInput: UITextField!
    @IBOutlet private var passwordInput: UITextField!
    @IBOutlet private var authButton: UIButton!
    @IBOutlet private var errorLabel: UILabel!
    
    @discardableResult
    func udapte(with inputData: LoginScreenViewInputData) -> Self {
        authButton.isEnabled = inputData.isCanSubmit
        errorLabel.isHidden = inputData.errorMessage == nil
        errorLabel.text = inputData.errorMessage ?? ""
        return self
    }
    
    @IBAction private func auth() {
        events.send(.authButtonPressed)
    }
    
    @IBAction private func formDidChange() {
        outputData.map(LoginScreenViewEvent.formDidChange).apply(events.send)
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
