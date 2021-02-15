//
//  MTMapAdapter.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation
import MapKit

class MTMapAdapter: NSObject {
    
    let delegate: MTMapProtocol
    
    //MARK: Constructor
    init(delegate: MTMapProtocol) {
        
        self.delegate = delegate
    }
    
    func deg2rad(degrees:Double) -> Double {
        
        return degrees * Double.pi / 180
    }
}

extension MTMapAdapter: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKPointAnnotation {
            
            pin.image = UIImage(named: "taxi")
            pin.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            
            pin.rightCalloutAccessoryView = mapsButton
            
            pin.canShowCallout = true
            pin.calloutOffset = CGPoint(x: -5, y: 5)
            return pin
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let searchDistance: Double =  5.00
        
        let lat1 = mapView.centerCoordinate.latitude - (searchDistance / 69)
        let lat2 = mapView.centerCoordinate.latitude + (searchDistance / 69)
        
        let long1 = mapView.centerCoordinate.longitude - searchDistance / fabs(cos(deg2rad(degrees: mapView.centerCoordinate.latitude))*69)
        let long2 = mapView.centerCoordinate.longitude + searchDistance / fabs(cos(deg2rad(degrees: mapView.centerCoordinate.latitude))*69)
        
        delegate.loadVehicleList(lat1: lat1, long1: long1, lat2: lat2, long2: long2)
    }
}
