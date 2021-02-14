//
//  MTMapPulleyViewController.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit
import Pulley

class MTMapPulleyViewController: PulleyViewController {
    
    //MARK: - Outlets
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupPulley()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.drawerPosition == .closed { self.setDrawerPosition(position: .closed, animated: false) }
    }
    
    //MARK: Layout
    func setupPulley() {
        
        guard let mapViewController = self.primaryContentViewController as? MTMapViewController else { return }
    }
}
