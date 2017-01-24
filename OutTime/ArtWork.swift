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
    let photo : UIImage
    
    init(title : String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, photo: UIImage) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.photo = photo
        
        super.init()
        
    }
    //mora da se primeni zbog prokola
    var subtitle : String? {
        return locationName
    }
}

//kreirao sam instancu od te klase i dodelio sam joj sve parametre!
let artWork = ArtWork(title: "Republic Square", locationName: "Belgrade Center", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 44.816088, longitude: 20.459962), photo: #imageLiteral(resourceName: "Trg republike"))
let boutique = ArtWork(title: "Boutique", locationName: "Belgrade Center", discipline: "Caffe Restoraunt ", coordinate: CLLocationCoordinate2D(latitude: 44.816158, longitude: 20.459794), photo: #imageLiteral(resourceName: "boutique"))
let nationalTheatre = ArtWork(title: "National Theatre", locationName: "Belgrade Center", discipline: "Theatre", coordinate: CLLocationCoordinate2D(latitude: 44.817018, longitude: 20.461017), photo: #imageLiteral(resourceName: "Narodno_pozoriste_u_Beogradu"))
let culturalCenterBelgrade = ArtWork(title: "Cultural Center Belgrade", locationName: "Belgrade Center", discipline: "Cultural Center", coordinate: CLLocationCoordinate2D(latitude: 44.815473, longitude: 20.459711), photo: #imageLiteral(resourceName: "kulturniCentarBeograda"))
let kfc = ArtWork(title: "KFC", locationName: "Belgrade Center", discipline: "Restoraunt", coordinate: CLLocationCoordinate2D(latitude: 44.818449, longitude: 20.458421), photo: #imageLiteral(resourceName: "kfc"))
let paulAndShark = ArtWork(title: "Paul and Shark", locationName: "Belgrade Center", discipline: "Boutique", coordinate: CLLocationCoordinate2D(latitude: 44.818190, longitude: 20.458724), photo: #imageLiteral(resourceName: "paulAndShark"))
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



