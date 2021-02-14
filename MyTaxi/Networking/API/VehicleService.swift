//
//  VehicleService.swift
//  MyTaxi
//
//  Created by Ana Finotti on 13/02/21.
//

import Foundation
import RxSwift

protocol VehicleServiceProtocol {
    
    func getVehicles(p2Lat: Double,
                     p1Lon: Double,
                     p1Lat: Double,
                     p2Lon: Double) -> Observable<VehicleList>
}

class VehicleService: VehicleServiceProtocol {
    
    func getVehicles(p2Lat: Double,
                     p1Lon: Double,
                     p1Lat: Double,
                     p2Lon: Double) -> Observable<VehicleList> {
        
        let url = ApiRouter.getVehicleList(p2Lat: p2Lat, p1Lon: p1Lon, p1Lat: p1Lat, p2Lon: p2Lon)
        
        return ApiClient.request(url)
    }
}
