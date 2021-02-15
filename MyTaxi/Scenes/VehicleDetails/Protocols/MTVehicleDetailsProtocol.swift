//
//  MTVehicleDetailsProtocol.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation

protocol MTVehicleDetailsProtocol {
    
    func getVehicle( at indexPath: IndexPath) -> Vehicle
    func itemSelected( at indexPath: IndexPath)

    func retrieveNumberOfItems() -> Int
}
