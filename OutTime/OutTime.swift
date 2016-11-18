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
    //kordinate beograda
    let initialLocation = CLLocation(latitude: 44.816088, longitude: 20.459962)
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        maps.setRegion(coordinateRegion, animated: true)
    }
}






typealias Internal = OutTime
extension Internal {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        maps.backgroundColor = UIColor.clear
        searchView.backgroundColor = UIColor.clear
        setSearch()
        centerMapOnLocation(location: initialLocation)
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














