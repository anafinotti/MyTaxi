//
//  Coordinate.swift
//  MyTaxi
//
//  Created by Ana Finotti on 15/02/21.
//

import Foundation

struct Coordinate: Codable {
    
    let latitude: Double?
    let longitude: Double?
    
    init(latitude: Double? = nil, longitude: Double? = nil) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
