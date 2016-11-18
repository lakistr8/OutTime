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
    @IBOutlet weak var maps: MKMapView!
    
}


typealias Internal = OutTime
extension Internal {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.backgroundColor = UIColor.clear
        setSearch()
        
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
