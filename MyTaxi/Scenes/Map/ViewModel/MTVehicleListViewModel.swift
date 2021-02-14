//
//  MTVehicleListViewModel.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class TPVehicleListViewModel {
    
    //MARK: - Properties
    private let vehicleServiceProtocol: VehicleServiceProtocol
    
    let isLoading = BehaviorRelay<Bool>(value: true)
    var selectedVehicle: Vehicle?
    
    lazy var vehicleList: VehicleList = {
        
        return VehicleList()
    }()
    
    //MARK: - Initializer
    init(vehicleServiceProtocol: VehicleServiceProtocol = VehicleService()) {
        
        self.vehicleServiceProtocol = vehicleServiceProtocol
    }
    
    //MARK: Layout
    func getNumberOfItems() -> Int {
        
        return vehicleList.vehicles?.count ?? 0
    }
    
    //MARK: - API Calls
    func fetchVehicleList(p2Lat: Double, p1Lon: Double, p1Lat: Double, p2Lon: Double) -> Observable<VehicleList> {
        
        vehicleServiceProtocol.getVehicles(p2Lat: p2Lat, p1Lon: p1Lon, p1Lat: p1Lat, p2Lon: p2Lon).map({
            
            self.vehicleList = $0
            return $0
        })
    }
    
    //MARK: - API Callback
    //    func getMovieList(_at indexPath: IndexPath) -> Movie {
    //
    //        return getMovie(_at: indexPath)
    //    }
    //
    //    fileprivate func getMovie(_at indexPath: IndexPath) -> Movie {
    //
    //        let listId = ListId.allCases[indexPath.section]
    //
    //        let moviesSection = movieList.filter({ $0.id == listId.rawValue }).first
    //
    //        guard let movie = moviesSection?.movies?[indexPath.row] else { fatalError() }
    //
    //        return movie
    //    }
}
