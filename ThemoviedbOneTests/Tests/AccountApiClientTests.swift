
import XCTest
@testable import ThemoviedbOne

final class AccountApiClientTests: BaseTestCase {
    
    private var requestBuilder: RequestBuilderMock!
    private var accountApiClient: AccountApiClient!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestBuilder = RequestBuilderMock()
        accountApiClient = ApiClient(
            requestBuilder: requestBuilder,
            session: makeMockSession(),
            decoder: JSONDecoder.makeBaseDecoder()
        )
    }
    
    func testMakeToken_shouldMakeRequest() {
        
        // given
        
        let request = accountApiClient.makeToken()
        var error: Error?
        var result: ApiClient.MakeTokenResponse?
        
        // when
        
        (result, error) = testSink(request)
        
        // then
        
        XCTAssertNotNil(result)
        XCTAssertNil(error)
        XCTAssertEqual(requestBuilder.path, "/authentication/token/new")
        XCTAssertEqual(requestBuilder.method?.rawValue, "GET")
        
        XCTAssertEqual(requestBuilder.urlParamters?["api_key"] as? String, "test_key")
        
        XCTAssertTrue(requestBuilder.jsonParamters?.isEmpty == true)
    }
    
    func testMakeToken_ShouldParseResponse() {
        
        // given
        
        let data =
        """
            {
              "success": true,
              "expires_at": "2020-05-30 18:26:10 UTC",
              "request_token": "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a"
            }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder.makeBaseDecoder()
        var result: ApiClient.MakeTokenResponse?
        
        // when
        
        result = try? decoder.decode(ApiClient.MakeTokenResponse.self, from: data)
        
        // then
        
        XCTAssertEqual(result?.requestToken, "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a")
        
    }
    
    func testValidateUser_shouldMakeRequest() {
        
        // given
        
        let request = accountApiClient.validateUser(
            username: "jonfir",
            password: "123456",
            token: "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a"
        )
        
        var error: Error?
        var result: ApiClient.ValidateUserResponse?
        
        // when
        
        (result, error) = testSink(request)
        
        // then
        
        XCTAssertNotNil(result)
        XCTAssertNil(error)
        XCTAssertEqual(requestBuilder.path, "/authentication/token/validate_with_login")
        XCTAssertEqual(requestBuilder.method?.rawValue, "POST")
        XCTAssertEqual(requestBuilder.urlParamters?["api_key"] as? String, "test_key")
        
        XCTAssertEqual(requestBuilder.jsonParamters?["username"] as? String, "jonfir")
        XCTAssertEqual(requestBuilder.jsonParamters?["password"] as? String, "123456")
        XCTAssertEqual(requestBuilder.jsonParamters?["request_token"] as? String, "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a")
    }
    
    func testValidateUser_ShouldParseResponse() {
        
        // given
        
        let data =
        """
            {
              "success": true,
              "expires_at": "2020-05-30 18:26:10 UTC",
              "request_token": "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a"
            }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder.makeBaseDecoder()
        var result: ApiClient.ValidateUserResponse?
        
        // when
        
        result = try? decoder.decode(ApiClient.ValidateUserResponse.self, from: data)
        
        // then
        
        XCTAssertEqual(result?.requestToken, "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a")
        
    }
    
    func testMakeSession_shouldMakeRequest() {
        
        // given
        
        let request = accountApiClient.makeSession(token: "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a")
        
        var error: Error?
        var result: ApiClient.MakeSessionResponse?
        
        // when
        
        (result, error) = testSink(request)
        
        // then
        
        XCTAssertNotNil(result)
        XCTAssertNil(error)
        XCTAssertEqual(requestBuilder.path, "/authentication/session/new")
        XCTAssertEqual(requestBuilder.method?.rawValue, "POST")
        XCTAssertEqual(requestBuilder.urlParamters?["api_key"] as? String, "test_key")
        
        XCTAssertEqual(requestBuilder.jsonParamters?["request_token"] as? String, "2cf1cee3c6052381bec8f2dea2de3ecfd63fdf1a")
    }
    
    func testMakeSession_ShouldParseResponse() {
        
        // given
        
        let data =
        """
            {
              "success": true,
              "session_id": "eed165357584010f57ab0ee9337b0ac5ab796d52"
            }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder.makeBaseDecoder()
        var result: ApiClient.MakeSessionResponse?
        
        // when
        
        result = try? decoder.decode(ApiClient.MakeSessionResponse.self, from: data)
        
        // then
        
        XCTAssertEqual(result?.sessionId, "eed165357584010f57ab0ee9337b0ac5ab796d52")
        
    }
    
}
