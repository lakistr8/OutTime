//
//  OutTime.swift
//  OutTime
//
//  Created by iosakademija on 11/16/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit
import MapKit

class OutTime: UIViewController {
    
    var searchText : String?
    var searchController : UISearchController!
    @IBOutlet weak var searchView : UITableView!
    @IBOutlet fileprivate weak var maps: MKMapView!
    //kordinate beograda dao sam geografsku sirinu i duzinu da bi mapa mogla da iscrta
    let initialLocation = CLLocation(latitude: 44.816088, longitude: 20.459962)
    //Locale je argument centralne tacke, region ce ima imati sever-jug i istog-zapad raspon od radiusa, zato radius podesavamo na 1000 metara i onda koristimo region radus na *2 jer je dobar sa unosom podataka na javnom atwork u jSon file.
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                      regionRadius * 2.0, regionRadius * 2.0)
        //set region govori mapi da nacrta odredjenu lokaciju na osnovu kordinata koje upisujemo kao parametar func!
        maps.setRegion(coordinateRegion, animated: true)
    }
}






typealias Internal = OutTime
extension Internal {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        searchView.backgroundColor = UIColor.clear
        //poziv za search bar u navigaton item-u
        setSearch()
        //poziv za centralnu tacku u mapi!
        centerMapOnLocation(location: initialLocation)
        //poziv za prikazivanje odredjene tacke na osnovu kordinata i teksta unosa
        maps.addAnnotation(artWork)
        maps.delegate = self
    }
}

extension OutTime  {
    
    func setSearch() {
        searchController = {
           let sc = UISearchController(searchResultsController: nil)
            
            
            sc.hidesNavigationBarDuringPresentation = false
            sc.dimsBackgroundDuringPresentation = false
            
            sc.searchBar.searchBarStyle = UISearchBarStyle.minimal
            self.navigationItem.titleView = sc.searchBar
            sc.searchBar.sizeToFit()
            
            return sc
        }()
    }
    
    func updateSearchResult(for searchControler: UISearchController) {
        self.searchText = searchControler.searchBar.text
        self.searchView.reloadData()
    }
}














