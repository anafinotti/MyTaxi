//
//  MTMapViewController.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit
import MapKit
import Pulley
import RxSwift
import RxCocoa

class MTMapViewController: UIViewController, PulleyPrimaryContentControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var adapter: MTMapAdapter!
    
    //Memory management
    let disposeBag = DisposeBag()
    
    lazy var viewModel: TPVehicleListViewModel = {
        
        return TPVehicleListViewModel()
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        adapter = MTMapAdapter(delegate: self)
        
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        self.setupViewModel()
    }
    
    func setupViewModel() {
        
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        self.viewModel.isLoading.accept(true)
        
        fetchVehicleList(p2Lat: 53.394655, p1Lon: 9.757589, p1Lat: 53.694865, p2Lon: 10.099891)
    }
    
    //MARK: ViewModel
    func fetchVehicleList(p2Lat: Double, p1Lon: Double, p1Lat: Double, p2Lon: Double) {
        
        viewModel.fetchVehicleList(p2Lat: p2Lat,
                                   p1Lon: p1Lon,
                                   p1Lat: p1Lat,
                                   p2Lon: p2Lon)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                
                self.tableView.reloadData()
                
            }, onError: { error in
                
                switch error {
                
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    print("Forbidden error")
                case ApiError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Map Protocol
extension MTMapViewController: MTMapProtocol {
    
    
}
