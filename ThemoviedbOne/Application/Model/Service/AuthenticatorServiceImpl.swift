import Foundation
import Combine

protocol AuthenticatorService {
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error>
}

class AuthenticatorServiceImpl: AuthenticatorService {
    
    private let sessionRepository: SessionRepository
    private let accountApiClient: AccountApiClient
    private var request: AnyCancellable?
    
    init(
        sessionRepository: SessionRepository,
        accountApiClient: AccountApiClient
    ) {
        
        self.sessionRepository = sessionRepository
        self.accountApiClient = accountApiClient
    }
    
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error> {
        request?.cancel()
        let operation = accountApiClient.makeToken().flatMap { result in
            
            self.accountApiClient.validateUser(
                username: credentials.login,
                password: credentials.password,
                token: result.requestToken
            )
            
        }.flatMap { result in
            
            self.accountApiClient.makeSession(token: result.requestToken)
            
        }.multicast { PassthroughSubject() }.autoconnect()
        
        request = operation.sink(
            receiveCompletion: toVoid,
            receiveValue: { [weak sessionRepository] result in
                
                sessionRepository?.sessionID = result.sessionId
        })
        
        return operation.map(toVoid).eraseToAnyPublisher()
    }
    
}

struct LoginCredentials {
    let login: String
    let password: String
    
    init?(login: String, password: String) {
        guard login.count >= 3 && password.count >= 3 else { return nil }
        
        self.login = login
        self.password = password
    }
}
