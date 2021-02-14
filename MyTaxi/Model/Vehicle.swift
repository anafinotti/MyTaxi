//
//  Vehicle.swift
//  MyTaxi
//
//  Created by Ana Finotti on 13/02/21.
//

import Foundation

enum State: String, Codable {
    
    case active = "ACTIVE"
    case inactive = "INACTIVE"
}

enum Type: String, Codable {
    
    case taxi = "TAXI"
}

struct VehicleList: Codable {
    
    var vehicles: [Vehicle]?
    
    enum CodingKeys: String, CodingKey {
        
        case vehicles = "poiList"
    }
    
    init(vehicles: [Vehicle]? = nil) {
        
        self.vehicles = vehicles
    }
}

struct Vehicle: Codable {
    
    let id: Double?
    let latitude: Double?
    let longitude: Double?
    let state: State?
    let type: Type?
    let heading: Double?
    
    init(id: Double? = nil, latitude: Double? = nil, longitude: Double? = nil, state: State? = nil, type: Type? = nil, heading: Double? = nil) {
        
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.state = state
        self.type = type
        self.heading = heading
    }
}

