//
//  NumberController.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-04.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit

var numbOfSets = 1
var numbOfRepetitions = 1
var vc: ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "entryStoryboard")

class NumberController: UIViewController
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.text = access.getNumberName()
        stepper.autorepeat = true
        stepper.maximumValue = 50
        stepper.minimumValue = 1
        
        if titleLabel.text == "Number of sets"
        {
            placeholderLabel.text = "sets"
            numbOfSets = access.getNumberOfSets()
            countLabel.text = String(format: "%02d", numbOfSets)
            stepper.value = Double(numbOfSets)
        }
        else
        {
            placeholderLabel.text = "repetitions"
            numbOfRepetitions = access.getNumberOfRepetitions()
            countLabel.text = String(format: "%02d", numbOfRepetitions)
            stepper.value = Double(numbOfRepetitions)
        }
    }
    
    @IBAction func stepperIncrementation(_ sender: UIStepper)
    {
        if titleLabel.text == "Number of sets"
        {
            numbOfSets = Int(stepper.value)
            countLabel.text = String(format: "%02d", numbOfSets)
            access.setNumberOfSets(numOfSets: numbOfSets)
        }
        else
        {
            numbOfRepetitions = Int(stepper.value)
            countLabel.text = String(format: "%02d", numbOfRepetitions)
            access.setNumberOfRepetitions(numOfRepetitions: numbOfRepetitions)
        }
    }
    
    @IBAction func setButton(_ sender: UIButton)
    {
        if titleLabel.text == "Number of sets"
        {
            access.setNumberOfSets(numOfSets: numbOfSets)
        }
        else
        {
            access.setNumberOfRepetitions(numOfRepetitions: numbOfRepetitions)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "VariableDefined"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setLength"), object: nil)
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
