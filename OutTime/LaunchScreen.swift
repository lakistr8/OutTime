//
//  LaunchScreen.swift
//  OutTime
//
//  Created by iosakademija on 11/14/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit



class LaunchScreen: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
    @IBOutlet weak var paswordField : UITextField!
    @IBOutlet weak var userNameField : UITextField!
    @IBOutlet weak var logInButton : UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
