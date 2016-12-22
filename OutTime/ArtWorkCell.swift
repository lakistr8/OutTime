//
//  ArtWorkCell.swift
//  OutTime
//
//  Created by iosakademija on 12/21/16.
//  Copyright © 2016 iosakademija. All rights reserved.
//

import UIKit

class ArtWorkCell: UITableViewCell {
    
    @IBOutlet weak var artWorksLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ArtWorkCell {
    
    func cofigure(_ artworks: [ArtWork]) {
        
        let work = [ArtWork]()
        
        artWorksLabel.text = String(work.count)
        
        
    }
    
}
