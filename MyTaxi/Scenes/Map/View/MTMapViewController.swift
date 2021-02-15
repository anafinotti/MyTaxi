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
        
        setupViewModel(p2Lat: 53.394655, p1Lon: 9.757589, p1Lat: 53.694865, p2Lon: 10.099891)
        setupInitialLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.pulleyViewController?.displayMode = .automatic
        self.pulleyViewController?.setDrawerPosition(position: .closed, animated: false)
    }
    
    //MARK: Layout
    func setupViewModel(p2Lat: Double, p1Lon: Double, p1Lat: Double, p2Lon: Double) {
        
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.isLoading.accept(true)
        
        fetchVehicleList(p2Lat: p2Lat, p1Lon: p1Lon, p1Lat: p1Lat, p2Lon: p2Lon)
    }
    
    func setupInitialLocation() {
        
        let initialLocation = CLLocation(latitude: 53.551864495081674, longitude: 10.000942264594983)
        mapView.centerToLocation(initialLocation)
        
        let center = CLLocation(latitude: 53.551864495081674, longitude: 10.000942264594983)
        let region = MKCoordinateRegion(
            center: center.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        mapView.delegate = adapter
    }
    
    func didFetchVehicles(vehicles: [Vehicle]) {
        
        viewModel.isLoading.accept(false)
        activityIndicator.isHidden = true
        
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
        pulleyViewController?.animationDuration = 0.5
        
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotations(viewModel.annotations)
        mapView.delegate = adapter
        
        pulleyViewController?.loadViewIfNeeded()
        
        if let detailsViewController = pulleyViewController?.drawerContentViewController as? MTVehicleDetailsViewController {
            
            detailsViewController.viewModel = viewModel
            detailsViewController.tableView.reloadData()
        }
    }
    
    //MARK: ViewModel
    func fetchVehicleList(p2Lat: Double, p1Lon: Double, p1Lat: Double, p2Lon: Double) {
        
        viewModel.fetchVehicleList(p2Lat: p2Lat,
                                   p1Lon: p1Lon,
                                   p1Lat: p1Lat,
                                   p2Lon: p2Lon)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                
                if let vehicles = response.vehicles {
                    
                    self.didFetchVehicles(vehicles: vehicles)
                }
                
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
    
    func loadVehicleList(lat1: Double, long1: Double, lat2: Double, long2: Double) {
        
        setupViewModel(p2Lat: lat2, p1Lon: long1, p1Lat: lat1, p2Lon: long2)

    }
}

extension MKMapView {
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}






