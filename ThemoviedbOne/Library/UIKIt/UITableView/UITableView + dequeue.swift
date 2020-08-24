import UIKit

extension UITableView {
    func dequeueReusableCell<View: UITableViewCell>(withType type: View.Type, for indexPath: IndexPath) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableCell(withIdentifier: indetifier, for: indexPath) as! View
        return cell
    }
    
    func register<View: UITableViewCell>(type: View.Type) {
        let identifier = String(describing: type)
        self.register(type, forCellReuseIdentifier: identifier)
    }
}
