//
//  MTMapWrapperViewController.swift
//  MyTaxi
//
//  Created by Ana Finotti on 15/02/21.
//

import UIKit

class MTMapWrapperViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var viewDock: UIView!
    @IBOutlet var constraintViewDockHeight: NSLayoutConstraint!
    @IBOutlet var buttonCall: UIButton!
    @IBOutlet var labelIconCall: UILabel!
    @IBOutlet var buttonEmail: UIButton!
    @IBOutlet var labelIconEmail: UILabel!
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.viewDock.alpha = 0
        self.constraintViewDockHeight.constant = 0
    }
    
    //MARK: - Layout
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pulleyViewController = segue.destination as? MTMapPulleyViewController else { return }
        
        pulleyViewController.pulleyViewControllerWrapper = self
    }
    
    func showDock(show: Bool, animated: Bool) {
        
        if animated {
            
            self.constraintViewDockHeight.constant = (show) ? 175 : 0
            
            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                self.viewDock.alpha = (show) ? 1 : 0
            }
        }
        else {
            
            self.viewDock.isHidden = !show
        }
    }
    
    func updateButtons() {
        
    }
    
    //MARK: - Actions
    @IBAction func didTapNavigateButton(_ sender: Any) {
        
        guard let pulleyViewController = self.children.first as? MTMapPulleyViewController else { return }
        
    }
}
