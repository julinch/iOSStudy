//
//  ViewController.swift
//  Calculator_Start
//
//  Created by Kirill Kirikov on 4/22/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputLabel: UILabel!

    var model = CalculatorModel()
    var inputStarted = false
    var dotUsed = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func input(_ sender: UIButton) {
        
        if inputLabel.text == "0" && sender.title(for: .normal)! == "0" //you cant enter a lot of zeros
        {
            return
        }
        
        if (!inputStarted) {
            inputLabel.text = ""
        }
        
        inputStarted = true
        inputLabel.text = "\(inputLabel.text!)\(sender.title(for: .normal)!)"
    
    }
    
    @IBAction func putDot(_ sender: UIButton) {

        if dotUsed {   //cant enter multiple dots in one number
            return
        }
        inputLabel.text! += "."
        dotUsed = true
       
    }
    
    @IBAction func evaluate(_ sender: UIButton) {
        
        let result = model.evaluate(operand: inputToDigit())
        inputLabel.text = "\(result)"
        inputStarted = false
        if dotUsed {
            dotUsed = false
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        
        if let operation = sender.title(for: .normal) {
            let result = model.operation(operand: inputToDigit(), operation: operation)
            inputLabel.text = "\(result)"
            inputStarted = false
            if dotUsed {
                dotUsed = false
            }
        }
    }
    
    @IBAction func reset(_ sender: UIButton)  // resets all of the stuff
    {
        inputLabel.text = "0"
        model.result = 0.0
        model.operation = nil
        inputStarted = false
        if dotUsed {
            dotUsed = false
        }
    }
    
    
    func inputToDigit() -> Double? {
        
        if !inputStarted {
            return nil
        }
        
        guard let input = inputLabel.text else {
            return 0
        }
        
        return Double(input) ?? 0
    }
    
}

