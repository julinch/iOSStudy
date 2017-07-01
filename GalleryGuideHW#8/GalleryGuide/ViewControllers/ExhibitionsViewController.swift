//
//  ExhibitionsViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 06.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class ExhibitionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var nearMeFilterButton: UIButton!
    @IBOutlet weak var mostPopularFilterButton: UIButton!
    @IBOutlet weak var lastChanceFilterButton: UIButton!
    @IBOutlet weak var followingFilterButton: UIButton!
    @IBOutlet weak var openingFilterButton: UIButton!
    @IBOutlet weak var backFromBlurViewButton: UIButton!
    
    
    
    
    var dropDownViewIsDisplayed: Bool = false
    var isAnimating: Bool = false
    
    
    @IBAction func filterView(_ sender: UIButton) {
        if (self.dropDownViewIsDisplayed) {
            self.hideBlurView()
        } else {
            self.showBlurView()
        }
        
       
    }
    @IBAction func goBackFromBlurView(_ sender: UIButton) {
        
        self.hideBlurView()
    }
    
    
    @IBAction func loadOpeningExhibitions(_ sender: UIButton) {
        ExhibitionsModel.instance.currentExhibitionFilterType = .opening
        
        ExhibitionsModel.instance.loadExhibitions(exhibitionsLoaded: tableView.reloadData)
        self.hideBlurView()
    }
    
    @IBAction func loadMostPopularExhibitions(_ sender: UIButton) {
        ExhibitionsModel.instance.currentExhibitionFilterType = .popular
        ExhibitionsModel.instance.loadExhibitions(exhibitionsLoaded: tableView.reloadData)
        self.hideBlurView()
    }
    
    @IBAction func loadNearMeExhibitions(_ sender: UIButton) {
        self.hideBlurView()
    }
    
    @IBAction func loadLastChanceExhibitions(_ sender: UIButton) {
        ExhibitionsModel.instance.currentExhibitionFilterType = .lastChance
        ExhibitionsModel.instance.loadExhibitions(exhibitionsLoaded: tableView.reloadData)
        self.hideBlurView()
    }
    
    @IBAction func loadFollowingExhibitions(_ sender: Any) {
        self.hideBlurView()
    }
 
    
    
    
    func hideBlurView() {
        
        var frame: CGRect = self.blurView.frame
        frame.origin.y = -frame.height
        self.animateBlurViewToFrame(frame: frame) {
            self.dropDownViewIsDisplayed = false
            self.blurView.isHidden = true
            self.filterButton.isHidden = false

        }
        
    }
    func showBlurView() {
       
        blurView.isHidden = false
        filterButton.isHidden = true
        var frame: CGRect = self.blurView.frame
        frame.origin.y = self.blurView.frame.height
        self.animateBlurViewToFrame(frame: frame) {
            self.dropDownViewIsDisplayed = true
        }

        
        
    }
    
    func animateBlurViewToFrame(frame: CGRect, completion: @escaping () -> Void) {
        if (!self.isAnimating) {
            self.isAnimating = true
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
                self.blurView.frame = frame
            }, completion: {(completed: Bool) -> Void in
                self.isAnimating = false
                if completed {
                    completion()
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.layer.borderWidth = 1.5
        filterButton.layer.cornerRadius = 12
        filterButton.layer.borderColor = UIColor.white.cgColor
        backFromBlurViewButton.layer.borderWidth = 1
        backFromBlurViewButton.layer.cornerRadius = 15
        backFromBlurViewButton.layer.borderColor = UIColor.white.cgColor
        let height: CGFloat = self.blurView.frame.size.height
        let width: CGFloat = self.blurView.frame.size.width
        self.blurView.frame = CGRect(x: 0, y: -height, width: width, height: height)
        blurView.isHidden = true
        
        
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ExhibitionsModel.instance.exhibitions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! ExhibitionTableViewCell
        let exhibition = ExhibitionsModel.instance.exhibitions[indexPath.row]
        
        if let exName = exhibition.name {
            cell.exhibitionNameLabel.text = exName
        } else {
            cell.exhibitionNameLabel.text = "No information available"
        }
        
        if let galName =  exhibition.gallery?.name {
            cell.galleryNameLabel.text = galName
        } else {
            cell.galleryNameLabel.text = "No information available"
        }
        
        if let authName = exhibition.authorName {
            cell.exhibitionAuthorNameLabel.text = authName
        } else {
            cell.exhibitionAuthorNameLabel.text = "No information available"
        }
        
        
        
            if let works = exhibition.works {
            if works.count > 0
            {
                let work = works[0]
                let url = URL(string: (work.imgPicture?.url)!)
                cell.imageView?.sd_setImage(with: url)
              
                
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let exhibition = ExhibitionsModel.instance.exhibitions
        if exhibition.count >= ExhibitionsModel.instance.limit {
        let lastElement = exhibition.count - 1
        if indexPath.row == lastElement {
            ExhibitionsModel.instance.skip += 10
            ExhibitionsModel.instance.loadExhibitions(exhibitionsLoaded: tableView.reloadData)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let exhibition = ExhibitionsModel.instance.exhibitions[indexPath.row]
        let destination = segue.destination as! DetailsViewController
        destination.exhibition = exhibition
    }
    
    
    
    
    
}
//
//
//

