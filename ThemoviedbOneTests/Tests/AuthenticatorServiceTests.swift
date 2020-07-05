import XCTest
import Combine
@testable import ThemoviedbOne

class AuthenticatorServiceTests: BaseTestCase {
    
    final var keychainWrapper: KeychainWrapperMock!
    final var accountApiClient: AccountApiClientMock!
    final var authenticatorService: AuthenticatorService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        keychainWrapper = KeychainWrapperMock()
        accountApiClient = AccountApiClientMock()
        let sessionRepository = SessionRepositoryImpl(keychainWrapper: keychainWrapper)
        authenticatorService = AuthenticatorServiceImpl(
            sessionRepository: sessionRepository,
            accountApiClient: accountApiClient
        )
    }
    
    func testLogin_shouldMakeRequest() {
        
        // given
        
        accountApiClient.makeToken_result = Result<ApiClient.MakeTokenResponse, Error>
            .Publisher(ApiClient.MakeTokenResponse(requestToken: "123"))
            .eraseToAnyPublisher()
        accountApiClient.validateUser_result =  Result<ApiClient.ValidateUserResponse, Error>
            .Publisher(ApiClient.ValidateUserResponse(requestToken: "456"))
            .eraseToAnyPublisher()
        accountApiClient.makeSession_result = Result<ApiClient.MakeSessionResponse, Error>
            .Publisher(ApiClient.MakeSessionResponse(sessionId: "789"))
            .eraseToAnyPublisher()
        let loginCredentials = LoginCredentials(login: "jonfir", password: "123456")!
        let request = authenticatorService.login(with: loginCredentials)
        
        // when
        
        let (_, error) = testSink(request)
        
        // then
        
        XCTAssertNil(error)
        XCTAssertEqual(keychainWrapper.values["sessionID"] as? String, "789")
        
        XCTAssertEqual(accountApiClient.validateUser_username, "jonfir")
        XCTAssertEqual(accountApiClient.validateUser_password, "123456")
        XCTAssertEqual(accountApiClient.validateUser_token, "123")
        
        XCTAssertEqual(accountApiClient.makeSession_token, "456")
        XCTAssertTrue(authenticatorService.isLogin)
        
    }
    

}
