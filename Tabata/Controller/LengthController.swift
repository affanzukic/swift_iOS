//
//  LengthController.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-04.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit

var setLength = 0
var breakLength = 0
var recoveryLength = 0
var preintervalLength = 0

class LengthController: UIViewController
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.text = access.getLengthName()
        stepper.autorepeat = true
        stepper.stepValue = 5.0
        stepper.maximumValue = 600
        stepper.minimumValue = 00
        
        if titleLabel.text == "Set length"
        {
            setLength = access.getSetLength()
            countLabel.text = String(format: "%02d", setLength)
            stepper.value = Double(setLength)
        }
        else if titleLabel.text == "Break length"
        {
            breakLength = access.getBreakLength()
            countLabel.text = String(format: "%02d", breakLength)
            stepper.value = Double(breakLength)
        }
        else if titleLabel.text == "Recovery length"
        {
            recoveryLength = access.getRecoveryLength()
            countLabel.text = String(format: "%02d", recoveryLength)
            stepper.value = Double(recoveryLength)
        }
        else
        {
            preintervalLength = access.getPreintervalLength()
            countLabel.text = String(format: "%02d", preintervalLength)
            stepper.value = Double(preintervalLength)
        }
    }

    @IBAction func stepperIncrement(_ sender: UIStepper)
    {
        if titleLabel.text == "Set length"
        {
            setLength = Int(stepper.value)
            countLabel.text = String(format: "%02d", setLength)
            access.setSetLength(sLength: setLength)
        }
        else if titleLabel.text == "Break length"
        {
            breakLength = Int(stepper.value)
            countLabel.text = String(format: "%02d", breakLength)
            access.setBreakLength(bLength: breakLength)
        }
        else if titleLabel.text == "Recovery length"
        {
            recoveryLength = Int(stepper.value)
            countLabel.text = String(format: "%02d", recoveryLength)
            access.setRecoveryLength(rLength: recoveryLength)
        }
        else
        {
            preintervalLength = Int(stepper.value)
            countLabel.text = String(format: "%02d", preintervalLength)
            access.setPreintervalLength(pLength: preintervalLength)
        }
    }
    
    @IBAction func setButton(_ sender: UIButton)
    {
        if titleLabel.text == "Set length"
        {
            access.setSetLength(sLength: setLength)
        }
        else if titleLabel.text == "Break length"
        {
            access.setBreakLength(bLength: breakLength)
        }
        else if titleLabel.text == "Recovery length"
        {
            access.setRecoveryLength(rLength: recoveryLength)
        }
        else
        {
            access.setPreintervalLength(pLength: preintervalLength)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setLength"), object: nil)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
