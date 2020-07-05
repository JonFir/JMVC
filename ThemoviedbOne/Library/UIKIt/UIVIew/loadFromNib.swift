import UIKit

extension UIView {

    static func loadView() -> Self {
        if isNibExist() {
            return loadFromNib()
        } else {
            return self.init(frame: UIScreen.main.bounds)
        }
    }

    static func loadFromNib() -> Self {
        
        let selfClass: AnyClass = self as AnyClass
        var className = NSStringFromClass(selfClass)
        let bundle = Bundle(for: selfClass)
        
        if bundle.path(forResource: className, ofType: "nib") == nil {
            className = (className as NSString).pathExtension
            if bundle.path(forResource: className, ofType: "nib") == nil {
                fatalError("No xib file for view \(type(of: self))")
            }
        }
        
        return view(bundle, className: className)
    }
    

    func loadNib(nibName: String? = nil) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = nibName ?? type(of: self).description().components(separatedBy: ".").last!

        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView // swiftlint:disable:this force_cast
    }

    // MARK: - Private Methods

    private static func isNibExist() -> Bool {
        let selfClass: AnyClass = self as AnyClass
        var className = NSStringFromClass(selfClass)
        let bundle = Bundle(for: selfClass)

        if bundle.path(forResource: className, ofType: "nib") == nil {
            className = (className as NSString).pathExtension
            if bundle.path(forResource: className, ofType: "nib") == nil {
                return false
            }
        }

        return true
    }

    private static func view<T: UIView>(_ bundle: Bundle, className: String) -> T {
        guard let nibContents = bundle.loadNibNamed(className, owner: nil, options: nil)
            else { fatalError("No xib file for view \(className)") }

        guard let view = nibContents.first(where: { ($0 as AnyObject).isKind(of: self) }) as? T
            else { fatalError("Xib doesn't have a view of such class \(self)") }
        return view
    }
}

