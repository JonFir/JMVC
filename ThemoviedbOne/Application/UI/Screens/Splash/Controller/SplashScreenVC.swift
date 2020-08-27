import UIKit

final class SplashScreenVC<View: SplashScreenView>: BaseViewController<View> {
    
    var onCheck: BoolClosure?
    
    private let loginStatusProvider: LoginStatusProvider
    
    init(loginStatusProvider: LoginStatusProvider) {
        self.loginStatusProvider = loginStatusProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLoginStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rootView.showCrown()
    }
    
    private func checkLoginStatus() {
        let isLogin = loginStatusProvider.isLogin
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.onCheck?(isLogin)
        }
        
    }
}
