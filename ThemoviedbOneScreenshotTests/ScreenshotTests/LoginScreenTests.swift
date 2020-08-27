import XCTest

class LoginScreenTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments = [TestConfiguration.Key.isTesting.rawValue]
    }
    
    func testLoginSuccess() throws {
        app.launchEnvironment = [TestConfiguration.Key.startFlow.rawValue: StartFlow.login.rawValue]
        app.launch()
        
        snapshot("LoginScreen_success_02")
        app.buttons["authButton"].tap()
        snapshot("LoginScreen_success_03")
    }
    
    func testLoginWrongLogin() throws {
        app.launchEnvironment = [TestConfiguration.Key.startFlow.rawValue: StartFlow.loginWrongLogin.rawValue]
        app.launch()
        snapshot("LoginScreen_wrongLogin_02")
        app.buttons["authButton"].tap()
        snapshot("LoginScreen_wrongLogin_03")
    }
    
    func testLoginNotInternet() throws {
        app.launchEnvironment = [TestConfiguration.Key.startFlow.rawValue: StartFlow.loginNotInternet.rawValue]
        app.launch()
        
        (app.textFields["loginInput"] as! UITextField).text = "TestTest"
        (app.textFields["loginInput"] as! UITextField).sendActions(for: .editingChanged)
        (app.textFields["passwordInput"] as! UITextField).text = "TestTest"
        (app.textFields["passwordInput"] as! UITextField).sendActions(for: .editingChanged)

        
        snapshot("LoginScreen_notInternet_02")
        app.buttons["authButton"].tap()
        snapshot("LoginScreen_notInternet_03")
    }
    
}
