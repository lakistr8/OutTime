//
//  ArtWork.swift
//  OutTime
//
//  Created by iosakademija on 11/18/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

//napravio sam posebnu klasu i pomocu nje cu imati pocetnu tacku sa centrom na osnovu kordinata i tokom klika na nju ispisace se svi detalji te tacke!
class ArtWork : NSObject, MKAnnotation {
    
    //mora title da se primeni zbog protokola
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
    //mora da se primeni zbog prokola
    var subtitle : String? {
        return locationName
    }
}

//kreirao sam instancu od te klase i dodelio sam joj sve parametre!
let artWork = ArtWork(title: "Republic Square", locationName: "Belgrade Center", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 44.816088, longitude: 20.459962))



extension OutTime : MKMapViewDelegate {
    //mapView(_:viewForAnnotation:) poziva svaki annotation koji smo dali mapi da bih dobili prikaz za svaki annotation
    private func mapView(mapVIew: MKMapView!, viewForAnnotation annotation:MKAnnotation) -> MKAnnotationView! {
        if let annotation = annotation as? ArtWork {
            let indentifier = "pin"
            var view : MKAnnotationView
            if let dequeuedView = mapVIew.dequeueReusableAnnotationView(withIdentifier: indentifier)! as? MKAnnotationView {
                //mape su tako podesene da one stave znak oznacavanja i ako objekta vise nema. Kod prvo proverava da li je za vecu upotrebu anntotion i onda kreira nov!
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                //ovde koristimo MKAnnotation klasu ako annotation view nije dequeued. Koristi oblacic koji izadje kad korisnik pritisne na pin da ispise naslov
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
