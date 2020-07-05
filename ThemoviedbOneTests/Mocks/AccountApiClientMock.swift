import Foundation
import Combine
@testable import ThemoviedbOne

final class AccountApiClientMock: AccountApiClient {
    
    var makeToken_result: AnyPublisher<ApiClient.MakeTokenResponse, Error>!
    
    func makeToken() -> AnyPublisher<ApiClient.MakeTokenResponse, Error> {
        return makeToken_result
    }
    
    
    private(set) var validateUser_username: String?
    private(set) var validateUser_password: String?
    private(set) var validateUser_token: String?
    var validateUser_result: AnyPublisher<ApiClient.ValidateUserResponse, Error>!
    
    func validateUser(
        username: String,
        password: String,
        token: String
    ) -> AnyPublisher<ApiClient.ValidateUserResponse, Error> {
        validateUser_username = username
        validateUser_password = password
        validateUser_token = token
        
        return validateUser_result
    }
    
    private(set) var makeSession_token: String?
    var makeSession_result: AnyPublisher<ApiClient.MakeSessionResponse, Error>!
    
    func makeSession(token: String) -> AnyPublisher<ApiClient.MakeSessionResponse, Error> {
        makeSession_token = token
        
        return makeSession_result
    }
    
}
