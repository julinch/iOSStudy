//
//  NextViewController.swift
//  maps-demo
//
//  Created by Juliya on 20.07.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let mapViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.present(mapViewController, animated:true, completion:nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
