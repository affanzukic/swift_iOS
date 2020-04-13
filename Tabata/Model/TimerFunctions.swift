//
//  TimerFunctions.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-08.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation
import AVFoundation

struct TimerFunctions
{
    // MARK: Variable declaration
    
    var timer = Timer()
    var access = Settings()
    var vc = ViewController()
    
    var setLength = 0
    var breakLength = 0
    var recoveryLength = 0
    var preintervalLength = 0
    var numberOfSets = 0
    var numberOfRepetitions = 0
    var tempNumberOfSets = 0
    
    var preintervalExists: Bool = false
    
    // MARK: Set variables from Settings.swift
    
    mutating func setVariables()
    {
        setLength = access.setLength
        breakLength = access.breakLength
        recoveryLength = access.recoveryLength
        preintervalLength = access.preintervalLength
        numberOfSets = access.numberOfSets
        numberOfRepetitions = access.numberOfRepetitions
        tempNumberOfSets = numberOfSets
        
        if access.checkPreinterval()
        {
            preintervalExists = true
        }
        else
        {
            preintervalExists = false
        }
    }
    
}
