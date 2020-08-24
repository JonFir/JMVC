import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    #if DEBUG
    private let appFactory: AppFactory = {
        let appFactory: AppFactory = TestConfiguration.shared.isTesting ? DiScreenshotMock() : Di()
        return appFactory
    }()
    #else
    private let appFactory: AppFactory = Di()
    #endif
    private var appCoordinator: Coordinator?

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        runUI()
        
        return true
    }
    
    private func runUI() {
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
        
        window.makeKeyAndVisible()
        coordinator.start()
    }
    
}

