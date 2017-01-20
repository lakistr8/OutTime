//
//  GridLayout.swift
//  OutTime
//
//  Created by iosakademija on 1/20/17.
//  Copyright © 2017 iosakademija. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.itemSize = CGSize(width: 150, height: 150)
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
        self.sectionInset = .zero
        self.scrollDirection = .vertical
        
    }
    
}
