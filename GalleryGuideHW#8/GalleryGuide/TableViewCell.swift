//
//  TableViewCell.swift
//  GalleryGuide
//
//  Created by Juliya on 26.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class ExhibitionTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryNameLabel: UILabel!
    @IBOutlet weak var exhibitionNameLabel: UILabel!
   
    @IBOutlet weak var exhibitionAuthorNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
