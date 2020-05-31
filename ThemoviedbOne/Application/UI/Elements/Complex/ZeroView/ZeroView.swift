import UIKit

final class ZeroView: UIView {
    private var onTryAgain: VoidClosure?
    
    @IBOutlet private var emojiLabel: UILabel!
    @IBOutlet private var messagelabel: UILabel!
    @IBOutlet private var tryAgainButton: UIButton!
     
    
    @discardableResult
    func update(with data: ErrorInputData) -> Self {
        
        emojiLabel.text = String(data.emoji)
        messagelabel.text = data.message
        onTryAgain = data.onTryAgain
        tryAgainButton.isHidden = data.onTryAgain == nil
        
        return self
    }
    
    @IBAction func tryAgainTapped() {
        onTryAgain?()
    }
}
