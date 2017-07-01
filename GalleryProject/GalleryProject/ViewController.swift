//
//  ViewController.swift
//  GalleryProject
//
//  Created by Juliya on 22.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    
    private var images:[GalleryImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = "Vehicles"
        
        let params = [
            "method": "flickr.photos.search",
            "api_key": "52e152e165ce50bb554446f59c89ea02",
            "tags": query,
            "format": "json",
            "nojsoncallback": "1"
        ]
        
        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions/opening")
                            .responseArray (keyPath: "photos.photo") {[weak self]
                            (response: DataResponse<[GalleryImage]>) in
                            
                            switch response.result {
                            case .success(let images):
                                self?.images = images
                                self?.tableView.reloadData()
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell") as! GalleryTableViewCell
        
        let galleryImage = images[indexPath.row]
        cell.galleryImageView.sd_setImage(with: galleryImage.imageURL)
        
        return cell
    }
    
}

