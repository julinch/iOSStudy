//
//  ViewController.swift
//  CalculatorWithUI
//
//  Created by Juliya on 07.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var didInputStarted: Bool = false
    
    var model = CalculatorModel()
    
    var currentDisplayValue: Double {
        set {
            if round(newValue) != newValue {
               inputDisplay.text = String(newValue)
            }
            else {
                inputDisplay.text = String(format: "%.0f", newValue)
            }
        }
        get {
            return Double(inputDisplay.text!)!
        }
    }
    
    @IBOutlet weak var inputDisplay: UITextField!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if inputDisplay.text == "0" && sender.currentTitle == "0" {
            return
        }
        
        if didInputStarted {
            inputDisplay.text = inputDisplay.text! + sender.currentTitle!
        }
        else
        {
            inputDisplay.text = sender.currentTitle!
            didInputStarted = true // lol kek
        }
    }
    
    
    @IBAction func performOperation(_ sender: UIButton  ) {
       guard let currentValue = Double(inputDisplay.text!) else {
        return
        }
        model.setOperand(currentValue)
        model.performOperation(sender.currentTitle!)
        currentDisplayValue = model.result ?? 0 // unwraps model.result if it contains any value or returns 0 if model.rezult is nil
        didInputStarted = false // Another comment
    }
    
    @IBAction func putDot(_ sender: UIButton) {
        if inputDisplay.text!.contains(".") {
            return
        }
        inputDisplay.text! += "."
        didInputStarted = true
    }
}

















