import UIKit

extension UIView {
    
    func hide() {
        guard !isHidden else { return }
        isHidden = true
    }
    
    func show() {
        guard isHidden else { return }
        isHidden = false
    }
    
}

