import XCTest

class SplashScreenTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
        
        app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments = [TestConfiguration.Key.isTesting.rawValue]
    }

    func testSplashScreen() throws {
        app.launchEnvironment = [TestConfiguration.Key.startFlow.rawValue: StartFlow.splash.rawValue]
        app.launch()
        snapshot("SplashScreen_01")
    }
    
}
