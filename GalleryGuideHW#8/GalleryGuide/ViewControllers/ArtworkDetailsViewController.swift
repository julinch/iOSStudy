//
//  ArtworkDetailsViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 30.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class ArtworkDetailsViewController: UIViewController {
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkNameLabel: UILabel!
    @IBOutlet weak var artworkTypeLabel: UILabel!
    @IBOutlet weak var artworkSizeLabel: UILabel!
    @IBOutlet weak var artworkYearLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    
    var work: WorkVO!

    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.borderColor = UIColor.white.cgColor
        shareButton.layer.borderWidth = 1
        shareButton.layer.cornerRadius = 30
        connectButton.layer.borderColor = UIColor.white.cgColor
        connectButton.layer.borderWidth = 1
        connectButton.layer.cornerRadius = 30
        
        
        artistNameLabel.text = work.author
        artworkNameLabel.text = work.title
        artworkSizeLabel.text = work.size
        artworkTypeLabel.text = work.type
        artworkYearLabel.text = work.year
        artworkImage.sd_setImage(with: URL(string: (work.imgPicture?.url)!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
