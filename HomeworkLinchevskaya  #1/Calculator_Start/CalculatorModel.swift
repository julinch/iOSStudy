//
//  CalculatorModel.swift
//  Calculator_Start
//
//  Created by Kirill Kirikov on 4/22/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import UIKit

class CalculatorModel {
    
    var result = 0.0
    var operation:String?
    
    func operation(operand: Double?, operation:String) -> Double {

        guard let inputOperand = operand else {
            self.operation = operation
            return result
            
        }
        
        guard let prevOperation = self.operation else {
            self.result = inputOperand
            self.operation = operation
            return result
        }
        
        print("\(result) \(prevOperation) \(inputOperand)")
        
        if (prevOperation == "+") {
            result += inputOperand
        }
        if (prevOperation == "−") {
            result -= inputOperand
        }
        if (prevOperation == "×") {
            result *= inputOperand
        }
        if (prevOperation == "÷") {
            result /= inputOperand
        }
        
        print("result = \(result)")
        
        self.operation = operation
        return result
    }
    
    func evaluate(operand: Double?) -> Double {
        
        if let prevOperation = self.operation, let inputOperand = operand {
            return operation(operand: inputOperand, operation: prevOperation)
        }
        
        return result
    }
    
}
