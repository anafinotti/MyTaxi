//
//  Constants.swift
//  MyTaxi
//
//  Created by Ana Finotti on 13/02/21.
//

struct Constants {
    
    static let baseUrl = "https://poi-api.mytaxi.com/"
    
    enum HttpHeaderField: String {
        
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        
        case json = "application/json"
    }
}
