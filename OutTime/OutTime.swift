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
    
    
    var arts = [ArtWork]()
    var localeManager = CLLocationManager()
    var searchText : String?
    var searchController : UISearchController!
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
    
//    let url = "https://http://www.bing.com/search?"
//    // metod za kreiranja url!
//    func updateSearchTextToGoogle(to someString: String) -> URL {
//        var s = url
//        
//        var niz:[String] = []
//        if someString == searchText {
//            niz.append("q=" + searchText! + someString)
//        }
//        
//        s += niz.joined()
//        
//        return URL(string: s)!
//    }
}


typealias Internal = OutTime
extension Internal {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadArtWorks()
        //poziv za search bar u navigaton item-u
//        setSearch()
        //poziv za centralnu tacku u mapi!
        centerMapOnLocation(location: initialLocation)
        //poziv za prikazivanje odredjene tacke na osnovu kordinata i teksta unosa
        maps.addAnnotations([artWork, boutique, nationalTheatre, culturalCenterBelgrade])
        maps.delegate = self
        
    }
}



//extension OutTime : UISearchResultsUpdating {
//    
//    func setSearch() {
//        searchController = {
//            
//           let sc = UISearchController(searchResultsController: nil)
//            sc.searchResultsUpdater = self
//            
//            sc.hidesNavigationBarDuringPresentation = false
//            sc.dimsBackgroundDuringPresentation = false
//            
//            sc.searchBar.searchBarStyle = UISearchBarStyle.minimal
//            self.navigationItem.titleView = sc.searchBar
//            sc.searchBar.sizeToFit()
//            
//            return sc
//        }()
//    }
//    func updateSearchResults (for searchControler: UISearchController) {
//        
//        self.searchText = searchControler.searchBar.text
//        self.tableView.reloadData()
//        
//    }
//}


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

extension OutTime {
    
    func loadArtWorks() {
        let artWork = ArtWork(title: "Republic Square", locationName: "Belgrade Center", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 44.816088, longitude: 20.459962), photo: #imageLiteral(resourceName: "Trg republike"))
        let boutique = ArtWork(title: "Boutique", locationName: "Belgrade Center", discipline: "Caffe Restoraunt ", coordinate: CLLocationCoordinate2D(latitude: 44.816158, longitude: 20.459794), photo: #imageLiteral(resourceName: "boutique"))
        let nationalTheatre = ArtWork(title: "National Theatre", locationName: "Belgrade Center", discipline: "Theatre", coordinate: CLLocationCoordinate2D(latitude: 44.817018, longitude: 20.461017), photo: #imageLiteral(resourceName: "Narodno_pozoriste_u_Beogradu"))
        let culturalCenterBelgrade = ArtWork(title: "Cultural Center Belgrade", locationName: "Belgrade Center", discipline: "Cultural Center", coordinate: CLLocationCoordinate2D(latitude: 44.815473, longitude: 20.459711), photo: #imageLiteral(resourceName: "kulturniCentarBeograda"))
        arts += [artWork, boutique, nationalTheatre, culturalCenterBelgrade]
    }
    
}


extension OutTime: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return arts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtWorkItems",
                                                      for: indexPath) as! ArtWorkItems
        let art = arts[indexPath.row]
        
        cell.artWorkName.text = art.title
        cell.artWorkImage.image = art.photo
        
        return cell
    }
}


extension OutTime: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! GridLayout
        
        let availableWidth = collectionView.bounds.size.width
        let columns = (availableWidth / 4 > 150) ? 4 : 2
        var itemTotalWidth = availableWidth - CGFloat(columns-1) * layout.minimumInteritemSpacing
        itemTotalWidth -= (layout.sectionInset.left + layout.sectionInset.right)
        
        let itemWidth = itemTotalWidth / CGFloat(columns)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

extension OutTime {
    
    @IBAction func didTapSearchBar(_ sender: UIBarButtonItem) {
        
        
        
    }
    
}

