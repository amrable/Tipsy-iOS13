//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
   
    var currTip:Float = 10
    var currPeople: Float = 2
    var finalResult: String = "0.0"
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        let percentage = sender.currentTitle!
        if percentage == "0%" {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            currTip = 0
        }else if percentage == "10%" {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            currTip = 10
        }else{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            currTip = 20
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        currPeople = Float(sender.value)
        splitNumberLabel.text = String(Int(currPeople))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let money = Float(billTextField.text ?? "0.0")
        let result = (money!) * (1+Float(currTip)/100.0) / currPeople
        finalResult =  String(format: "%.2f", result)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = finalResult
            destinationVC.split = Int(currPeople)
            destinationVC.tip = Int(currTip)
        }
    }
}

