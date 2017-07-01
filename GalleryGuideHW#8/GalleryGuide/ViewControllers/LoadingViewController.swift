//
//  LoadingViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 06.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIdentifier: UIActivityIndicatorView!
       
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        ExhibitionsModel.instance.loadExhibitions(exhibitionsLoaded: onLoadingCompleted)
    }
    
    func onLoadingCompleted() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let fbVC = storyboard.instantiateViewController(withIdentifier: "FacebookLoginViewController")
        
        self.navigationController?.setViewControllers([fbVC], animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
