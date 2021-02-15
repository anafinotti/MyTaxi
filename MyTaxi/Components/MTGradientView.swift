//
//  MTGradientView.swift
//  MyTaxi
//
//  Created by Ana Finotti on 15/02/21.
//

import UIKit

@IBDesignable open class MTGradientView: MTView {
    
    @IBInspectable public var startColor: UIColor = UIColor.clear
    @IBInspectable public var startLocation: Float = 0 { didSet { self.updateLocations() } }
    @IBInspectable public var endColor: UIColor = UIColor.clear
    @IBInspectable public var endLocation: Float = 0 { didSet { self.updateLocations() } }
    @IBInspectable public var horizontal: Bool = false { didSet { self.updateLocations() } }
    
    private var gradientLayer: CAGradientLayer?
    
    override open func draw(_ rect: CGRect) {
        
        if self.gradientLayer != nil { return }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        
        if self.endLocation > 0 {
            
            gradient.locations = [NSNumber.init(value: self.startLocation), NSNumber.init(value: self.endLocation)]
        }
        
        if self.horizontal {
            
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        layer.addSublayer(gradient)
        
        self.gradientLayer = gradient
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if let gradientLayer = self.gradientLayer { gradientLayer.frame = self.bounds }
        self.updateColors()
    }
    
    private func updateColors() {
        
        self.gradientLayer?.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    private func updateLocations() {
        
        self.gradientLayer?.locations = [NSNumber.init(value: self.startLocation), NSNumber.init(value: self.endLocation)]
        self.gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        
        if self.horizontal {
            
            self.gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            self.gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
    }
}
