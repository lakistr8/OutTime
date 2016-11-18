//
//  ArtWork.swift
//  OutTime
//
//  Created by iosakademija on 11/18/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import Foundation
import MapKit


class ArtWork : NSObject, MKAnnotation {
    
    let title : String?
    let locationName : String
    let discipline : String
    let coordinate : CLLocationCoordinate2D
    
    init(title : String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
        
    }
    
    var subtitle : String? {
        return locationName
    }
}


let artWork = ArtWork(title: "Republic Square", locationName: "Belgrade Center", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 44.816088, longitude: 20.459962))

extension OutTime : MKMapViewDelegate {
    func mapView(mapVIew: MKMapView!, viewForAnnotation annotation:MKAnnotation) -> MKAnnotationView! {
        if let annotation = annotation as? ArtWork {
            let indentifier = "pin"
            var view : MKAnnotationView
            if let dequeuedView = mapVIew.dequeueReusableAnnotationView(withIdentifier: indentifier)! as? MKAnnotationView {
                
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: indentifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)  as UIView
            }
            return view
        }
        return nil
    }
}
