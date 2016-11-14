//
//  OutTime.swift
//  OutTime
//
//  Created by iosakademija on 11/13/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit

class OutTime: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
    @IBOutlet weak var reklamView : UIView!
    @IBOutlet weak var stuffSearch : UISearchBar!
    @IBOutlet weak var stuffLabel : UILabel!
    @IBOutlet weak var accImage : UIImageView!
    @IBOutlet weak var nameFields : UITextField!
    @IBOutlet var listOfBrands : UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfBrands.backgroundColor = UIColor.clear
        
        
    }
}

