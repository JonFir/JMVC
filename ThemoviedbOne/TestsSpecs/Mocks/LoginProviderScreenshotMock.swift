import Foundation
import Combine

#if DEBUG
final class LoginProviderScreenshotMock: LoginProvider {
    let state = CurrentValueSubject<LoginProviderState, Never>(LoginProviderState.inital)
    
    func auth() {
        switch TestConfiguration.shared.startFlow {
        case .login:
            state.value = state.value.with(isAuth: true).with(error: nil)
        case .loginWrongLogin:
            state.value = state.value.with(error: ApiClientError.unauthorized).with(isAuthInProgress: false)
        case .loginNotInternet:
            state.value = state.value.with(error: ApiClientError.other).with(isAuthInProgress: false)
        default:
            preconditionFailure()
        }
    }
    
    func update(loginCredentials: LoginCredentials) {
        self.state.value = self.state.value.with(loginCredentials: loginCredentials)
    }
    
}

#endif
