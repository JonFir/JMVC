import UIKit

final class ErrorView: UIView {
    private var onTryAgain: VoidClosure?
    
    @IBOutlet private var messagelabel: UILabel!
    @IBOutlet private var tryAgainButton: UIButton!
    
    @discardableResult
    func update(with data: ErrorInputData) -> Self {
        messagelabel.text = String(data.emoji) + " " + data.message
        onTryAgain = data.onTryAgain
        tryAgainButton.isHidden = data.onTryAgain == nil
        
        return self
    }
    
    @IBAction func tryAgainTapped() {
        onTryAgain?()
    }
    
}
