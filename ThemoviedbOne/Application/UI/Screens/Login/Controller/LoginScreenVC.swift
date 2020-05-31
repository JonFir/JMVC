import UIKit
import Combine

final class LoginScreenVC<View: LoginScreenView>: BaseViewController<View> {
    
    typealias ErrorMessage = String
    
    var onLogin: VoidClosure?
    
    private let loginProvider: LoginProvider
    private var cancalables = Set<AnyCancellable>()
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.udapte(with: makeLoginScreenViewInputData(from: loginProvider.state.value))
        
        rootView.events.sink { [weak self] in self?.onViewEvent($0) }.store(in: &cancalables)
        loginProvider.state.sink { [weak self] in self?.onStateChange($0) }.store(in: &cancalables)
    }
    
    private func onViewEvent(_ event: LoginScreenViewEvent) {
        switch event {
        case .formDidChange(let formData):
            
            LoginCredentials(login: formData.login, password: formData.password)
                .apply(loginProvider.update(loginCredentials:))
            
        case .authButtonPressed:
            
            loginProvider.auth()
        }
    }
    
    private func onStateChange(_ state: LoginProviderState) {
        if state.isAuth {
            onLogin?()
        } else {
            rootView.udapte(with: makeLoginScreenViewInputData(from: state))
        }
    }
    
    private func makeLoginScreenViewInputData(from state: LoginProviderState) -> LoginScreenViewInputData {
        let isCanSubmit = state.loginCredentials != nil && !state.isAuthInProgress
        
        let errorMessage = state.error.map(makeErrorMessage)
        
        return LoginScreenViewInputData(isCanSubmit: isCanSubmit, errorMessage: errorMessage)
    }
    
    private func makeErrorMessage(from error: Error) -> String {
        switch error {
        case let error as ApiClientError where error == .unauthorized:
            return "Invalid username and/or password: You did not provide a valid login."
        default:
            return "Developer mistake. Please try turning it off and on again"
        }
    }
    
}
