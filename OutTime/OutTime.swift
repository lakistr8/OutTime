//
//  OutTime.swift
//  OutTime
//
//  Created by iosakademija on 11/16/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit

class OutTime: UIViewController {
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var searchView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.backgroundColor = UIColor.clear
        
    }

}
