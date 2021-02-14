//
//  ApiRouter.swift
//  MyTaxi
//
//  Created by Ana Finotti on 13/02/21.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getVehicleList(p2Lat: Double,
                        p1Lon: Double,
                        p1Lat: Double,
                        p2Lon: Double)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let baseUrl = try Constants.baseUrl.asURL()
        
        guard let urlString = baseUrl.appendingPathComponent(path).absoluteString.removingPercentEncoding else { fatalError("wrong url format") }
        guard let url = URL(string: urlString) else { fatalError("wrong url format") }
        
        var urlRequest = URLRequest(url: url)
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        //Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            
            switch method {
            
            case .get:
                return URLEncoding.default
                
            case .post:
                return JSONEncoding.default
                
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .getVehicleList:
            return .get
        }
    }
    
    //MARK: - Path
    private var path: String {
        
        switch self {
        
        case .getVehicleList:
            
            return "PoiService/poi/v1"
        }
    }
    
    //MARK: - Parameters
    private var parameters: Parameters? {
        
        switch self {
        
        case .getVehicleList(let p2Lat,
                             let p1Lon,
                             let p1Lat,
                             let p2Lon):
            
            return ["p2Lat": p2Lat,
                    "p1Lon": p1Lon,
                    "p1Lat": p1Lat,
                    "p2Lon": p2Lon]
        }
    }
}
