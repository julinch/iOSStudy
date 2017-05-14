//
//  CalculatorModel.swift
//  CalculatorWithUI
//
//  Created by Juliya on 07.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

struct CalculatorModel
{
    typealias UnaryFunction     =   (Double)-> Double
    typealias BinaryFunction    =   (Double, Double)->Double
    
    private enum Operation {
        case unary(UnaryFunction)
        case binary(BinaryFunction)
        case constant(Double)
        case equal
        case clear
        
    }
    
    private struct PendingBinaryOperation {
        let firstOperand:   Double
        let function:       BinaryFunction
        
        func performOperation(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var accomulator: Double?
    private var pbo: PendingBinaryOperation?
    
    private let operations: [String:Operation]  = [
        "±":    Operation.unary(-),
        "√":    Operation.unary(sqrt),
        "cos":  Operation.unary(cos),
        "sin":  Operation.unary(sin),
        "tan":  Operation.unary(tan),
        "log":  Operation.unary(log),
        "pi":   Operation.constant(Double.pi), //𝛑
        "CE":   Operation.constant(0),
        "exp":  Operation.constant(M_E), //𝑒
        "+":    Operation.binary(+),
        "−":    Operation.binary(-),
        "×":    Operation.binary(*),
        "÷":    Operation.binary(/),
        "=":    Operation.equal,
        "C":    Operation.clear
    ]
    
    mutating func setOperand(_ operand: Double) {
        accomulator = operand
    }
    
    mutating func performOperation(_ symbol: String) {
       guard let operation = operations[symbol]
        else {
            return
        }
        switch operation {
        case .constant(let value):
            accomulator = value
        case .unary(let f):
            if accomulator != nil {
                accomulator = f(accomulator!)
            }
        case .binary(let f):
            if accomulator != nil  {
                if pbo != nil {
                    accomulator = pbo!.performOperation(with: accomulator!)
                }
                pbo = PendingBinaryOperation(firstOperand: accomulator!, function: f)
            }
        case .equal:
            if pbo != nil  && accomulator != nil {
                accomulator = pbo!.performOperation(with: accomulator!)
                pbo = nil
            }
        case .clear:
            pbo = nil
            accomulator = 0
        
        }
    }
    
    
    var result: Double? {
        get { 
            return accomulator
        }
    }
    
}
