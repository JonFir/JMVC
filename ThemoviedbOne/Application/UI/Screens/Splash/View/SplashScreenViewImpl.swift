import UIKit
import SnapKit

protocol SplashScreenView: UIView {
    
    func showCrown()
    
}

final class SplashScreenViewImpl: UIView, SplashScreenView {
    
    // MARK: - Private Properties
    
    private let titleView = UILabel()
    private let iconView = UIImageView()
    private let barCodeView = UIImageView()
    private let crownLayer = CAShapeLayer()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func showCrown() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 1
        strokeAnimation.duration = 1
        
        
        let fadeAnimation = CABasicAnimation(keyPath: "fillColor")
        fadeAnimation.fromValue = UIColor.clear.cgColor
        fadeAnimation.toValue = UIColor.blue.cgColor
        fadeAnimation.beginTime = 1.0
        fadeAnimation.duration = 1
        
        let group = CAAnimationGroup()
        group.duration = 2.0
        group.animations = [strokeAnimation, fadeAnimation]
        fadeAnimation.fillMode = .backwards
        
        crownLayer.strokeEnd = 1.0
        crownLayer.fillColor = UIColor.blue.cgColor
        crownLayer.add(group, forKey: nil)
    }
    
    // MARK: - Private Methods
    
    
    
    private func setup() {
        backgroundColor = .white
        setupTitleView()
        
        layer.addSublayer(crownLayer)
        setupCrownLayer()
        
        setupBarCodeView()
    }
    
    
    private func setupTitleView() {
        titleView.text = Localizations.SplashScreen.title
        
        titleView.textColor = .black
        titleView.font = FontFamily.Ubuntu.regular.font(size: 18)
        titleView.textAlignment = .center
        
        addSubview(titleView)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    
    private func setupBarCodeView() {
        barCodeView.image = Asset.calendar.image
        
        addSubview(barCodeView)
        barCodeView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupIconView() {
        iconView.image = UIImage(systemName: "clock")
        addSubview(iconView)
        
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupCrownLayer() {
        
        var frame = CGRect(x: 0, y: 100, width: 126, height: 86)
        crownLayer.path = makeCrownPath(frame: frame).cgPath
        frame.origin.x = (self.frame.width - 126) / 2
        crownLayer.frame = frame
        crownLayer.lineWidth = 2
        crownLayer.strokeColor = UIColor.red.cgColor
        crownLayer.strokeEnd = 0.0
        crownLayer.fillColor = UIColor.clear.cgColor
    }
    
    private func makeCrownPath(frame: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.01587 * frame.width, y: frame.minY + 0.43255 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.09527 * frame.width, y: frame.minY + 0.31564 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.01587 * frame.width, y: frame.minY + 0.36794 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.05146 * frame.width, y: frame.minY + 0.31564 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.17159 * frame.width, y: frame.minY + 0.46419 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.14786 * frame.width, y: frame.minY + 0.31564 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.18635 * frame.width, y: frame.minY + 0.39007 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.46470 * frame.width, y: frame.minY + 0.37036 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.14739 * frame.width, y: frame.minY + 0.58633 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.42384 * frame.width, y: frame.minY + 0.70216 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.43579 * frame.width, y: frame.minY + 0.22232 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.47505 * frame.width, y: frame.minY + 0.28598 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.46380 * frame.width, y: frame.minY + 0.26384 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.41267 * frame.width, y: frame.minY + 0.14023 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.42154 * frame.width, y: frame.minY + 0.20134 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.41267 * frame.width, y: frame.minY + 0.17238 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.49206 * frame.width, y: frame.minY + 0.02326 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.41267 * frame.width, y: frame.minY + 0.07562 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.44825 * frame.width, y: frame.minY + 0.02326 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.57141 * frame.width, y: frame.minY + 0.14017 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.53596 * frame.width, y: frame.minY + 0.02326 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.57141 * frame.width, y: frame.minY + 0.07562 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.54834 * frame.width, y: frame.minY + 0.22226 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.57141 * frame.width, y: frame.minY + 0.17232 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.56258 * frame.width, y: frame.minY + 0.20127 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.51951 * frame.width, y: frame.minY + 0.37030 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.52038 * frame.width, y: frame.minY + 0.26372 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.50916 * frame.width, y: frame.minY + 0.28591 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.81258 * frame.width, y: frame.minY + 0.46412 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.56025 * frame.width, y: frame.minY + 0.70197 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.83683 * frame.width, y: frame.minY + 0.58633 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.88895 * frame.width, y: frame.minY + 0.31557 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.79791 * frame.width, y: frame.minY + 0.39001 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.83631 * frame.width, y: frame.minY + 0.31557 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.96825 * frame.width, y: frame.minY + 0.43255 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.93276 * frame.width, y: frame.minY + 0.31557 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.96825 * frame.width, y: frame.minY + 0.36794 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.87804 * frame.width, y: frame.minY + 0.54838 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.96825 * frame.width, y: frame.minY + 0.50386 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.92531 * frame.width, y: frame.minY + 0.55820 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.73012 * frame.width, y: frame.minY + 0.97674 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.82089 * frame.width, y: frame.minY + 0.53645 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.74687 * frame.width, y: frame.minY + 0.83885 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.49232 * frame.width, y: frame.minY + 0.91621 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.65371 * frame.width, y: frame.minY + 0.93752 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.57349 * frame.width, y: frame.minY + 0.91666 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.25405 * frame.width, y: frame.minY + 0.97674 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.41115 * frame.width, y: frame.minY + 0.91660 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.33042 * frame.width, y: frame.minY + 0.93752 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.10609 * frame.width, y: frame.minY + 0.54832 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.23726 * frame.width, y: frame.minY + 0.83885 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.16323 * frame.width, y: frame.minY + 0.53645 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.01587 * frame.width, y: frame.minY + 0.43255 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.05882 * frame.width, y: frame.minY + 0.55820 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.01587 * frame.width, y: frame.minY + 0.50386 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.01587 * frame.width, y: frame.minY + 0.43255 * frame.height))
        bezierPath.close()
        return bezierPath
    }
}
