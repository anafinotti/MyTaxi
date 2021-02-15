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
    lazy var pulleyViewControllerWrapper = MTMapWrapperViewController()
    var poiDetails: [Vehicle]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.drawerPosition == .closed { self.setDrawerPosition(position: .closed, animated: false) }
    }
}
