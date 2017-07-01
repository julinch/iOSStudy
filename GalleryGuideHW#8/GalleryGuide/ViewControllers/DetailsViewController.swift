//
//  DetailsViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 06.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var exhibitionNameLabel: UILabel!
    @IBOutlet weak var exhibitionAuthorLabel: UILabel!
    @IBOutlet weak var exhibitionDurationLabel: UILabel!
    @IBOutlet weak var galleryNameLabel: UILabel!
    @IBOutlet weak var hideGalleryInfoButton: UIButton!
    @IBOutlet weak var galleryWorkingHoursLabel: UILabel!
    @IBOutlet weak var galleryWorkingHoursView: UIView!
    @IBOutlet weak var galleryPhoneLabel: UILabel!
    @IBOutlet weak var galleryPhoneNumberView: UIView!
    @IBOutlet weak var galleryAddressLabel: UILabel!
    @IBOutlet weak var galleryAddressView: UIView!
    @IBOutlet weak var galleryLinkLabel: UILabel!
    @IBOutlet weak var galleryLinkView: UIView!
    @IBOutlet weak var galleryFacebookLabel: UILabel!
    @IBOutlet weak var galleryFacebookView: UIView!
    @IBOutlet weak var galleryInfoStackView: UIStackView!
    @IBOutlet weak var galleryInfoTextView: UITextView!
    @IBOutlet weak var exhibitionImagesCollectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var artistDescriptionTextView: UITextView!
    @IBOutlet weak var linksTextView: UITextView!
    
    
   
    
    var exhibition: ExhibitionVO!
    let galleryInfoViews: Int = 5
    var galleryInfoViewsAreHidden: Int = 0
    
    @IBAction func hideGalleryInfoButton(_ sender: UIButton) {
        if galleryInfoStackView.isHidden {
            galleryInfoStackView.isHidden = false
            galleryInfoTextView.isHidden = false
            sender.transform = sender.transform.rotated(by: CGFloat(Double.pi))
            
        } else {
            galleryInfoStackView.isHidden = true
            galleryInfoTextView.isHidden = true
            sender.transform =  sender.transform.rotated(by: CGFloat(Double.pi))
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        exhibitionImagesCollectionView.delegate = self
        exhibitionImagesCollectionView.dataSource = self
        
        exhibitionNameLabel.text = exhibition.name
        exhibitionAuthorLabel.text = exhibition.authorName
        if let startDateString = exhibition.startDate?.formattedDateString, let endDateString = exhibition.endDate?.formattedDateString {

            exhibitionDurationLabel.text = "\(startDateString) - \(endDateString)"
        }
        if let galleryName = exhibition.gallery?.name {
            galleryNameLabel.text = galleryName
        } else {
            hideGalleryInfoButton.isHidden = true
        }
        if let workingHours = exhibition.gallery?.schedule {
            galleryWorkingHoursLabel.text = workingHours
        } else {
            galleryWorkingHoursView.isHidden = true
            galleryInfoViewsAreHidden += 1
        }
        if let galPhone = exhibition.gallery?.phone {
            galleryPhoneLabel.text = galPhone
        } else {
            galleryPhoneNumberView.isHidden = true
            galleryInfoViewsAreHidden += 1
        }
        if let address = exhibition.gallery?.address {
            galleryAddressLabel.text =  address
        } else {
            galleryAddressView.isHidden = true
            galleryInfoViewsAreHidden += 1
        }
        if let link = exhibition.gallery?.link {
            galleryLinkLabel.text = link
        } else {
            galleryLinkView.isHidden = true
            galleryInfoViewsAreHidden += 1
        }
        if let facebook = exhibition.gallery?.facebook {
            galleryFacebookLabel.text = facebook
        } else {
            galleryFacebookView.isHidden = true
            galleryInfoViewsAreHidden += 1
        }
        if galleryInfoViewsAreHidden == galleryInfoViews {
            hideGalleryInfoButton.isHidden = true
        }
        galleryInfoTextView.text = exhibition.gallery?.galleryDescription

        if let about =  exhibition.about {
            textView.text = about
        } else {
            textView.text = "No information available"
        }
        if let links =  exhibition.gallery?.link {
            linksTextView.text = links
        } else {
            linksTextView.text = "No information available"
        }
        if let authDescr =  exhibition.authorDescription {
            artistDescriptionTextView.text = authDescr
        } else {
            artistDescriptionTextView.text = "No information available"
        }

    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let works = exhibition.works, (exhibition.works?.count)! > 0 {
            return works.count
        } else {
            exhibitionImagesCollectionView.isHidden = true
            return 0
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exhibitionImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ExhibitionImageCollectionViewCell", for: indexPath) as! ExhibitionImagesCollectionViewCell
        cell.exhibitionImage.sd_setImage(with: URL(string: exhibition.works![indexPath.row].imgPicture!.url!))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = exhibitionImagesCollectionView.indexPath(for: cell)!
        let work = exhibition.works?[indexPath.row]
        let destination = segue.destination as! ArtworkDetailsViewController
        destination.work = work
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
