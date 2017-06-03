//
//  ViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 24.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataLoader = DataLoader()
        let result = dataLoader.loadExhibitions()
        print(result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

