//
//  MTFakeSelectionButton.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit

public class MTFakeSelectionButton: UIButton {

    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        
        self.alpha = 0.08
        
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        
        self.addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        self.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        
        self.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        
        
        
        DispatchQueue.main.async {
            
            guard let superview = self.superview else { return }
            
            self.layer.cornerRadius = superview.layer.cornerRadius
        }
    }
    
    @objc func touchDown() {

        self.backgroundColor = .black
    }
    @objc func touchUpInside() {
    
        self.backgroundColor = .clear
    }
    @objc func touchUpOutside() {
    
        self.backgroundColor = .clear
    }
    @objc func touchDragEnter() {
    
        self.backgroundColor = .black
    }
    @objc func touchDragOutside() {
    
        self.backgroundColor = .clear
    }
    @objc func touchDragExit() {
    
        self.backgroundColor = .clear
    }
    @objc func touchCancel() {
    
        self.backgroundColor = .clear
    }
}
