import Combine
import Foundation

protocol LoginProvider {
    
    var state: CurrentValueSubject<LoginProviderState, Never> { get }
    
    func auth()
    
    func update(loginCredentials: LoginCredentials)
}


final class LoginProviderImpl: LoginProvider {
    
    let state = CurrentValueSubject<LoginProviderState, Never>(LoginProviderState.inital)
    
    private let authenticator: AuthenticatorService
    private var request: AnyCancellable?

    init(authenticator: AuthenticatorService) {
        self.authenticator = authenticator
    }
    
    func auth() {
        guard let loginCredentials = state.value.loginCredentials else { return }
        
        request?.cancel()
        
        request = authenticator.login(with: loginCredentials)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.state.value = self.state.value.with(error: error).with(isAuthInProgress: false)
        },
            receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.state.value = self.state.value.with(isAuth: true).with(error: nil)
            })
    }
    
    func update(loginCredentials: LoginCredentials) {
        self.state.value = self.state.value.with(loginCredentials: loginCredentials)
    }
    
}


struct LoginProviderState {
    let error: Error?
    let loginCredentials: LoginCredentials?
    let isAuthInProgress: Bool
    let isAuth: Bool
    
    static let inital = LoginProviderState(
        error: nil,
        loginCredentials: nil,
        isAuthInProgress: false,
        isAuth: false
    )
    
    func with(error: Error?) -> Self {
        LoginProviderState(
            error: error,
            loginCredentials: loginCredentials,
            isAuthInProgress: isAuthInProgress,
            isAuth: isAuth
        )
    }
    
    func with(loginCredentials: LoginCredentials?) -> Self {
        LoginProviderState(
            error: error,
            loginCredentials: loginCredentials,
            isAuthInProgress: isAuthInProgress,
            isAuth: isAuth
        )
    }
    
    func with(isAuthInProgress: Bool) -> Self {
        LoginProviderState(
            error: error,
            loginCredentials: loginCredentials,
            isAuthInProgress: isAuthInProgress,
            isAuth: isAuth
        )
    }
    
    func with(isAuth: Bool) -> Self {
        LoginProviderState(
            error: error,
            loginCredentials: loginCredentials,
            isAuthInProgress: isAuthInProgress,
            isAuth: isAuth
        )
    }
    
}
