//
//  OutTime.swift
//  OutTime
//
//  Created by iosakademija on 11/16/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit
import MapKit
import WebKit

enum Errors : Error {
    case invalidResponse
    case networkError(NSError?)
    case locationIsNotIncluded(String)
}



class OutTime: UIViewController, UISearchControllerDelegate {
    
    var localeManager = CLLocationManager()
    var searchText : String?
    var searchController : UISearchController!
    @IBOutlet weak var searchView : UITableView!
    @IBOutlet weak var maps: MKMapView!
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
    
    let url = "https://http://www.bing.com/search?"
    // metod za kreiranja url!
    func updateSearchTextToGoogle(to someString: String) -> URL {
        var s = url
        
        var niz:[String] = []
        if someString == searchText {
            niz.append("q=" + searchText! + someString)
        }
        
        s += niz.joined()
        
        return URL(string: s)!
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
        maps.addAnnotations([artWork, boutique, nationalTheatre])
        maps.delegate = self
        
    }
}



extension OutTime : UISearchResultsUpdating {
    
    func setSearch() {
        searchController = {
            
           let sc = UISearchController(searchResultsController: nil)
            sc.searchResultsUpdater = self
            
            sc.hidesNavigationBarDuringPresentation = false
            sc.dimsBackgroundDuringPresentation = false
            
            sc.searchBar.searchBarStyle = UISearchBarStyle.minimal
            self.navigationItem.titleView = sc.searchBar
            sc.searchBar.sizeToFit()
            
            return sc
        }()
    }
    func updateSearchResults (for searchControler: UISearchController) {
        
        self.searchText = searchControler.searchBar.text
        self.searchView.reloadData()
        self.searchController.delegate = self
    }
}

extension OutTime {
    
    func updateSearchBarToNetwork(for searchBar:UISearchController,
                                  completionHandler: @escaping (Double? , Errors?) -> Void ) {
        
        let url = updateSearchTextToGoogle(to: searchText!)
        let task = URLSession.shared.dataTask(with: url) {
            data, urlResponse, error in
            
            if let error = error {
                completionHandler(nil, Errors.networkError(error as NSError?))
                return
            }

            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                completionHandler(nil, Errors.invalidResponse)
                return
            }
            
            if httpURLResponse.statusCode != 200 {
                completionHandler(nil, Errors.invalidResponse)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, Errors.invalidResponse)
                return
            }
            
            guard let result = String(data: data, encoding: .utf8) else {
                completionHandler(nil, Errors.invalidResponse)
                return
            }
            
            guard result.characters.count > 0 else {
                completionHandler(nil, Errors.invalidResponse)
                return
            }
            
            let lines = result.components(separatedBy: "")
        }
      task.resume()
    }
}

extension OutTime {
    //metod za soptvenu lokaciju!
    
    func checkLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            maps.showsUserLocation = true
        } else {
            localeManager.requestWhenInUseAuthorization()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //metod za sopstvenu lokaciju
        checkLocation()
    }
}
