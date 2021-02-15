//
//  MTVehicleListViewModel.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class TPVehicleListViewModel {
    
    //MARK: - Properties
    private let vehicleServiceProtocol: VehicleServiceProtocol
    
    let isLoading = BehaviorRelay<Bool>(value: true)
    var selectedVehicle: Vehicle?
    
    lazy var annotations: [MKPointAnnotation] = {
        
        return [MKPointAnnotation]()
    }()
    
    lazy var vehicleList: VehicleList = {
        
        return VehicleList()
    }()
    
    //MARK: - Initializer
    init(vehicleServiceProtocol: VehicleServiceProtocol = VehicleService()) {
        
        self.vehicleServiceProtocol = vehicleServiceProtocol
    }
    
    //MARK: Layout
    func getVehicle( at indexPath: IndexPath) -> Vehicle {
        
        guard let vehicles = vehicleList.vehicles else { fatalError("list is empty") }
        
        return vehicles[indexPath.row]
    }
    
    func getNumberOfItems() -> Int {
        
        return vehicleList.vehicles?.count ?? 0
    }
    
    func getAnnotations() {
        
        guard let vehicles = vehicleList.vehicles else { return }
        
        annotations = [MKPointAnnotation]()
        
        for vehicle in vehicles where vehicle.coordinate?.latitude != nil && vehicle.coordinate?.longitude != nil {
            
            let annotation = MKPointAnnotation()
            annotation.title = vehicle.type?.rawValue
            
            if let latitude = vehicle.coordinate?.latitude,
               let longitude = vehicle.coordinate?.longitude {
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            annotations.append(annotation)
        }
    }
    
    //MARK: - API Calls
    func fetchVehicleList(p2Lat: Double, p1Lon: Double, p1Lat: Double, p2Lon: Double) -> Observable<VehicleList> {
                
        vehicleServiceProtocol.getVehicles(p2Lat: p2Lat, p1Lon: p1Lon, p1Lat: p1Lat, p2Lon: p2Lon).map({
            
            self.vehicleList = $0
            self.getAnnotations()

            return $0
        })
    }
}
