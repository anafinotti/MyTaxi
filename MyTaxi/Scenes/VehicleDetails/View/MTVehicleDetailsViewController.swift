//
//  MTVehicleDetailsViewController.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit
import Pulley
import MapKit
import RxSwift
import RxCocoa

class MTVehicleDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var gripperView: UIView!
    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var topSeparator: UIView!
    
    @IBOutlet var gripperTopConstraint: NSLayoutConstraint!
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var adapter: MTVehicleDetailsAdapter!
    var hasAppeared = false
    
    lazy var viewModel: TPVehicleListViewModel = {
        
        return TPVehicleListViewModel()
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        adapter = MTVehicleDetailsAdapter(delegate: self)
        
        setupTableView()
    }
    
    //MARK: - Layout
    func setupTableView() {
        
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    //MARK: - Actions
    //MARK: - Delegates
}

//MARK: Pulley Delegate
extension MTVehicleDetailsViewController: PulleyDrawerViewControllerDelegate {
    
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        
        return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        
        return 100 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
}

extension MTVehicleDetailsViewController: MTVehicleDetailsProtocol {
    
    func retrieveNumberOfItems() -> Int {
        
        viewModel.getNumberOfItems()
    }
    
    func getVehicle(at indexPath: IndexPath) -> Vehicle {
        
        return viewModel.getVehicle(at: indexPath)
    }
    
    func itemSelected(at indexPath: IndexPath) {
                
        viewModel.selectedAnnotation = viewModel.annotations[indexPath.row]
        
        if let mapViewController = pulleyViewController?.primaryContentViewController as? MTMapViewController {
            
            let region = MKCoordinateRegion(center: viewModel.selectedAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        
            mapViewController.mapView.setRegion(region, animated: true)
            
        }
    }
}
