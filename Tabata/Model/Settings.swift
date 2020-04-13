//
//  Settings.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-04.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation


struct Settings
{
    // MARK: Variables
    
    var numberName: String = ""
    var lengthName: String = ""
    
    var numberOfRepetitions = 1
    var numberOfSets = 1
    var setLength = 0
    var recoveryLength = 0
    var breakLength = 0
    var preintervalLength = 0
    
    var setsRemaining = ""
    
    // MARK: Number settings
    
    mutating func setNumberName(nameToSet: String)
    {
        numberName = nameToSet
    }
    
    func getNumberName() -> String
    {
        return numberName
    }
    
    mutating func setLengthName(nameToSet: String)
    {
        lengthName = nameToSet
    }
    
    func getLengthName() -> String
    {
        return lengthName
    }
    
    
    func getNumberOfSets() -> Int
    {
        return numberOfSets
    }
    
    mutating func setNumberOfSets(numOfSets: Int)
    {
        numberOfSets = numOfSets
    }
    
    func getNumberOfRepetitions() -> Int
    {
        return numberOfRepetitions
    }
    
    mutating func setNumberOfRepetitions(numOfRepetitions: Int)
    {
        numberOfRepetitions = numOfRepetitions
    }
    
    // MARK: Length
    
    func getSetLength() -> Int
    {
        return setLength;
    }
    
    mutating func setSetLength(sLength: Int)
    {
        setLength = sLength
    }
    
    func getBreakLength() -> Int
    {
        return breakLength;
    }
    
    mutating func setBreakLength(bLength: Int)
    {
        breakLength = bLength
    }
    
    func getRecoveryLength() -> Int
    {
        return recoveryLength;
    }
    
    mutating func setRecoveryLength(rLength: Int)
    {
        recoveryLength = rLength
    }
    
    func getPreintervalLength() -> Int
    {
        return preintervalLength;
    }
    
    mutating func setPreintervalLength(pLength: Int)
    {
        preintervalLength = pLength
    }
    
    // MARK: Timer-related functions
    
    func checkPreinterval() -> Bool
    {
        if preintervalLength > 0
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    mutating func setSetName()
    {
        let num = getNumberOfSets()
        setsRemaining = "\(num) sets remaining."
    }
}
