//
//  MTButton.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit

@IBDesignable open class MTButton: UIButton {
        
    @IBInspectable public var borderColor: UIColor {
        
        set { layer.borderColor = newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor!) }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        
        set {
            layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable public var iconText: String = "" { didSet { self.setupIcon() } }
    @IBInspectable public var iconFontName: String = "" { didSet { self.setupIcon() } }
    @IBInspectable public var iconFontSize: CGFloat = 24 { didSet { self.setupIcon() } }
    @IBInspectable public var iconColor: UIColor = UIColor.clear { didSet { self.setupIcon() } }
    
    @IBInspectable public var spinnerColor: UIColor = UIColor.clear { didSet { self.setupIndicator() } }
    
    @IBInspectable public var shadowWidth: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowHeight: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowRadius: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowOpacity: Float = 0 { didSet { setupShadow() } }
    
    @IBInspectable public var singleCornerRadius: CGFloat = 0 { didSet { setRoundedCorners() } }
    @IBInspectable public var topLeft:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var topRight:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var bottomLeft:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var bottomRight:Bool = false { didSet { setRoundedCorners() } }
    
    @IBInspectable public var usesSelectedBackgrounColor: Bool = false
    @IBInspectable public var selectedBackgrounColor: UIColor = UIColor.clear { didSet { self.originalBackgoundColor = self.backgroundColor } }
    
    private var indicator: UIActivityIndicatorView?
    private var textForIndicator: String?
    private var originalBackgoundColor: UIColor?
    private var iconFont = UIFont.systemFont(ofSize: 24)
    public static var defaultIconFont = UIFont.boldSystemFont(ofSize: 24)
    
    public override var isSelected: Bool {
        
        didSet {
            
            if self.usesSelectedBackgrounColor { self.backgroundColor = (self.isSelected) ? self.selectedBackgrounColor : self.originalBackgoundColor }
            
            self.setupIconColor()
        }
    }
    
    override public var isEnabled: Bool {
        
        didSet { self.setupIsEnabledAlpha() }
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchDown)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchUpOutside)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchDragEnter)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchDragOutside)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchDragExit)
        self.addTarget(self, action: #selector(self.setupIconColor), for: .touchCancel)
        
        self.setupIsEnabledAlpha()
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.setRoundedCorners()
        self.setupShadow()
        self.setupIconColor()
    }
    
    private func setupIsEnabledAlpha() {
        
        self.alpha = (isEnabled) ? 1 : 0.7
    }
    
    private func setRoundedCorners() {
        
        if self.singleCornerRadius > 0 {
            
            var corners = UIRectCorner()
            
            if self.topLeft { corners.insert(.topLeft) }
            if self.topRight { corners.insert(.topRight) }
            if self.bottomLeft { corners.insert(.bottomLeft) }
            if self.bottomRight { corners.insert(.bottomRight) }
            
            let maskPAth = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii:CGSize(width: self.singleCornerRadius, height: self.singleCornerRadius))
            
            let maskLayer = CAShapeLayer()
            
            maskLayer.frame = self.bounds
            maskLayer.path = maskPAth.cgPath
            
            self.layer.mask = maskLayer
        }
    }
    
    func setupIndicator() {
        
        self.indicator?.removeFromSuperview()
        
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        indicator.color = self.spinnerColor
        self.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.indicator = indicator
    }
    
    public func startLoading() {
        
        self.textForIndicator = self.title(for: .normal)
        self.setTitle("", for: .normal)
        
        self.indicator?.isHidden = false
        self.indicator?.startAnimating()
        self.isUserInteractionEnabled = false
    }
    
    public func stopLoading() {
        
        if self.indicator?.isAnimating != true { return }
        
        self.setTitle(self.textForIndicator, for: .normal)
        
        self.indicator?.stopAnimating()
        self.indicator?.isHidden = true
        self.isUserInteractionEnabled = true
    }
    
    func setupIcon() {
        
        if !self.iconText.isEmpty {
            
            if self.iconFontName == "" { self.iconFont = MTButton.defaultIconFont }
            else {
                
                guard let font = UIFont(name: self.iconFontName, size: self.iconFontSize) else { return }
                self.iconFont = font
            }
            
            let string = NSString(string: self.iconText)
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: self.iconFont.pointSize, height: self.iconFont.pointSize), false, 0)
            
            let attrs = [NSAttributedString.Key.font: self.iconFont,
                         NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle()
            ]
            
            string.draw(in: CGRect(x: 0, y: 0, width: self.iconFont.pointSize, height: self.iconFont.pointSize), withAttributes: attrs)
            
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
            
            UIGraphicsEndImageContext()
            
            self.setImage(image, for: UIControl.State.normal)
            
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            self.imageView?.tintColor = self.iconColor
        }
    }
    
    @objc func setupIconColor() {
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (timer) in
                
                if !self.iconText.isEmpty {
                    
                    if !self.isSelected { self.imageView?.tintColor = self.iconColor }
                    else if let textColor = self.titleLabel?.textColor { self.imageView?.tintColor = textColor }
                }
            }
        }
    }
    
    func setupShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: self.shadowWidth, height: self.shadowHeight)
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowRadius = self.shadowRadius
    }
}
