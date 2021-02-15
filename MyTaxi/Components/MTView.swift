//
//  MTView.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit

@IBDesignable open class MTView: UIView {
    
    @IBInspectable public var borderColor: UIColor {
        
        set { layer.borderColor = newValue.cgColor }
        
        get { return UIColor(cgColor: layer.borderColor!) }
        
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        
        set { layer.borderWidth = newValue }
        
        get { return layer.borderWidth }
        
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        
        set { layer.cornerRadius = newValue }
        
        get { return layer.cornerRadius }
        
    }
    
    @IBInspectable public var singleCornerRadius: CGFloat = 0 { didSet { setRoundedCorners() } }
    @IBInspectable public var topLeft:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var topRight:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var bottomLeft:Bool = false { didSet { setRoundedCorners() } }
    @IBInspectable public var bottomRight:Bool = false { didSet { setRoundedCorners() } }
    
    @IBInspectable public var shadowWidth: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowHeight: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowRadius: CGFloat = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowOpacity: Float = 0 { didSet { setupShadow() } }
    @IBInspectable public var shadowSpread: CGFloat = 0 { didSet { setupShadow() } }
    
    private var shadowView:UIView?
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.setRoundedCorners()
        self.setupShadow()
    }
    
    func setRoundedCorners() {
        
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
    
    func setupShadow() {
        
        if self.shadowWidth == 0 && self.shadowHeight == 0 && self.shadowRadius == 0 && self.shadowOpacity == 0 { return }
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: self.shadowWidth, height: self.shadowHeight)
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowRadius = self.shadowRadius
        
        if self.shadowSpread == 0 {
            
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
        else {
            
            let spread = -self.shadowSpread
            let rect = self.bounds.insetBy(dx: spread, dy: spread)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIView {
    
    public var allSubViews : [UIView] {
        
        var array = [self.subviews].flatMap {$0}
        
        array.forEach { array.append(contentsOf: $0.allSubViews) }
        
        return array
    }
}
