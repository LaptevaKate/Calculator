//
//  ViewController.swift
//  Calculator
//
//  Created by Екатерина Лаптева on 4.03.22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    var numberfromScreen: Double = 0
    var firstNumber: Double = 0
    var operation: Int = 0
    var mathSign: Bool = false
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }
    //MARK: - Methods
    func roundedString(_ firstNumber: Double, _ numberfromScreen: Double, sign: String) -> String {
        var result: Double = 0.0
        switch sign {
        case "+":
            result = firstNumber + numberfromScreen
        case "/":
            if numberfromScreen == 0 {
                return "ERROR"
            } else {
                result = firstNumber / numberfromScreen
            }
        case "*":
            result = firstNumber * numberfromScreen
        case "-":
            result = firstNumber - numberfromScreen
        default:
            print("Result error")
        }
        return result == result.rounded() ? String(Int(result)) : String(result)
    }
    
    //MARK: - IBOutlets
            
    @IBOutlet weak var resultLabel: UILabel!
      
    
    //MARK: - IBActions
    
    @IBAction func numbers(_ sender: UIButton) {
        guard let text = resultLabel.text else { return }
        if mathSign {
            resultLabel.text = String(sender.tag)
            mathSign = false
        } else if sender.restorationIdentifier == "comma" && !text.contains(".") {
            resultLabel.text = resultLabel.text! + String(".")
        } else if resultLabel.text == "0" {
            resultLabel.text = String(sender.tag)
        } else if !(sender.restorationIdentifier == "comma") {
            resultLabel.text = text + String(sender.tag)
        }
        numberfromScreen = Double(resultLabel.text!)!
    }
            
    @IBAction func buttons(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 10 && sender.tag != 17 {
            firstNumber = Double(resultLabel.text!)!
            operation = sender.tag
            mathSign = true
        } else if sender.tag == 17 {
            if operation == 11 {
                resultLabel.text = roundedString(0, firstNumber, sign: "-")
            } else if operation == 12 {
                resultLabel.text = String(firstNumber / 100)
            } else if operation == 13 {
                resultLabel.text = roundedString(firstNumber, numberfromScreen, sign: "/")
            } else if operation == 14 {
                resultLabel.text = roundedString(firstNumber, numberfromScreen, sign: "*")
            } else if operation == 15 {
                resultLabel.text = roundedString(firstNumber, numberfromScreen, sign: "-")
            } else if operation == 16 {
                resultLabel.text = roundedString(firstNumber, numberfromScreen, sign: "+")
            }
        } else if sender.tag == 10 {
            resultLabel.text = "0"
            firstNumber = 0
            numberfromScreen = 0
            operation = 0
        }
    }
}
