import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    typealias OnBackButtonTap = () -> Void
    
    var rootView: View { view as! View }
    var onBackButtonTap: OnBackButtonTap?
    
    override func loadView() {
        view = View.loadView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            onBackButtonTap?()
        }
    }
    
}
