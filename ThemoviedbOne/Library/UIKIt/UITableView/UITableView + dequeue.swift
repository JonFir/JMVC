import UIKit

extension UITableView {
    func dequeueReusableCell<View: UITableViewCell>(withType type: View.Type, for indexPath: IndexPath) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableCell(withIdentifier: indetifier, for: indexPath) as! View
        return cell
    }
    
    func register<View: UITableViewCell>(nibType: View.Type) {
        let identifier = String(describing: nibType)
        let bundle = Bundle(for: nibType)
        let nib = UINib(nibName: identifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
