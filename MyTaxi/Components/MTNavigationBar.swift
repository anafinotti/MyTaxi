//
//  MTNavigationBar.swift
//  MyTaxi
//
//  Created by Ana Finotti on 15/02/21.
//

import UIKit

class MTNavigationBar: MTGradientView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.shadowWidth = 0
        self.shadowHeight = 0
        self.shadowRadius = 4
        self.shadowOpacity = 0.3
        
        self.horizontal = true
        
        self.startColor = UIColor(named: "navBarPrimary") ?? .clear
        self.endColor = UIColor(named: "navBarSecondary") ?? .clear
    
        self.superview?.bringSubviewToFront(self)
        
        guard let contentView = self.subviews.first else { return }
        
        var allLabels = contentView.subviews.compactMap { $0 as? UILabel }
        allLabels = allLabels.filter({ $0.font.fontName != UIFont(name: "MaterialDesignIcons", size: 12)?.fontName })
   
        for label in allLabels { label.font = UIFont.systemFont(ofSize: 20, weight: .medium) }
    }
    

}
