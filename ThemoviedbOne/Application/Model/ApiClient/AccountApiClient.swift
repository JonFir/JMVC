import Foundation
import Alamofire
import Combine

protocol AccountApiClient {
    func makeToken() -> AnyPublisher<ApiClient.MakeTokenResponse, Error>
    
    func validateUser(
        username: String,
        password: String,
        token: String
    ) -> AnyPublisher<ApiClient.ValidateUserResponse, Error>
    
    func makeSession(token: String) -> AnyPublisher<ApiClient.MakeSessionResponse, Error>
}

extension ApiClient: AccountApiClient {
    
    struct MakeTokenResponse: Decodable {
        let requestToken: String
    }
    
    func makeToken() -> AnyPublisher<ApiClient.MakeTokenResponse, Error> {
        
        let request = requestBuilder.build(
            path: "/authentication/token/new",
            method: .get,
            urlParamters: [:],
            jsonParamters: [:]
        )
        
        return performRequest(request)
    }
    
    struct ValidateUserResponse: Decodable {
        let requestToken: String
    }
    
    func validateUser(
        username: String,
        password: String,
        token: String
    ) -> AnyPublisher<ApiClient.ValidateUserResponse, Error> {
        
        let request = requestBuilder.build(
            path: "/authentication/token/validate_with_login",
            method: .post,
            urlParamters: [:],
            jsonParamters: [
                "username": username,
                "password": password,
                "request_token": token
            ]
        )
        return performRequest(request)
    }
    
    struct MakeSessionResponse: Decodable {
        let sessionId: String
    }
    
    func makeSession(token: String) -> AnyPublisher<ApiClient.MakeSessionResponse, Error> {
        let request = requestBuilder.build(
            path: "/authentication/session/new",
            method: .post,
            urlParamters: [:],
            jsonParamters: ["request_token": token]
        )
        
        return performRequest(request)
    }
    
}
