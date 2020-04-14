//
//  ViewController.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-04.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: Variable declaration

var minutesTotal: Int = 0
var secondsTotal: Int = 0
var totalTime: Int = 0
var tempTime: Int = 0
var noOfSets = 0
var noOfRepetitions = 0
var sLength = 0
var rLength = 0
var bLength = 0
var pLength = 0
var tempTotalTime = 0
var tempNumberOfSets = 0

var timer = Timer()
var preintervalTimerDone = false
var setTimerDone = false
var breakTimerDone = false
var recoveryTimerDone = false
var pauseTimer = false
var timerAudioDone = false

class ViewController: UIViewController
{
    // MARK: Variable declaration - part 2
    
    @IBOutlet weak var setsRemainingLabel: UILabel!
    @IBOutlet weak var currentLength: UILabel!
    @IBOutlet weak var totalLength: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    let setsRemainingNotificationListener = Notification.Name(rawValue: "VariableDefined")
    let setLengthNotificationListener = Notification.Name(rawValue: "setLength")
    var ap = CountdownAudioPlayer()
    
    override func viewDidLoad()
    {
        // MARK: Start-up setting
        
        super.viewDidLoad()
        
        startPauseButton.setTitle("START", for: .normal)
        
        access.setSetName()
        ap.setUpVoice()
        setsRemainingLabel.text = "\(access.numberOfSets) sets remaining."
        currentLength.text = "\(String(format: "%02d", 0)):\(String(format: "%02d", 0))"
        totalLength.text = "\(String(format: "%02d", 0)):\(String(format: "%02d", 0))"
        currentLength.textColor = .none
        
        NotificationCenter.default.addObserver(
        self, selector: #selector(setSetsRemaining),
        name: setsRemainingNotificationListener, object: nil)
        NotificationCenter.default.addObserver(
        self, selector: #selector(setTotalTimeRemaining),
        name: setLengthNotificationListener, object: nil)
    }
    
    @objc func setSetsRemaining()
    {
        noOfSets = access.numberOfSets
        setsRemainingLabel.text = "\(noOfSets) sets remaining."
        
        noOfRepetitions = access.numberOfRepetitions
        sLength = access.setLength
        rLength = access.recoveryLength
        bLength = access.breakLength
        pLength = access.preintervalLength
        tempTotalTime = totalTime
    }
    
    @objc func setTotalTimeRemaining()
    {
        totalTime = (((access.setLength + access.breakLength) * access.numberOfSets) + access.recoveryLength) * access.numberOfRepetitions + access.preintervalLength
        
        minutesTotal = totalTime / 60
        secondsTotal = totalTime % 60
        
        totalLength.text = "\(String(format: "%02d", totalTime / 60)):\(String(format: "%02d", totalTime % 60))"
        
        noOfSets = access.numberOfSets
        noOfRepetitions = access.numberOfRepetitions
        sLength = access.setLength
        rLength = access.recoveryLength
        bLength = access.breakLength
        pLength = access.preintervalLength
        tempTotalTime = totalTime

        
        if access.checkPreinterval()
        {
            tempTime = access.preintervalLength
            
            currentLength.text = "\(String(format: "%02d", tempTime / 60)):\(String(format: "%02d", tempTime % 60))"
        }
        else
        {
            tempTime = access.setLength
            
            currentLength.text = "\(String(format: "%02d", tempTime / 60)):\(String(format: "%02d", tempTime % 60))"
        }
    }
    
    // MARK: Timer functions
    
    func runPreintervalTimer()
    {
        if access.checkPreinterval() == true && preintervalTimerDone == false
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePreintervalTimer), userInfo: nil, repeats: true)
            currentLength.textColor = .none
            timerAudioDone = false
        }
        else
        {
            currentLength.text = "\(String(format: "%02d", sLength / 60)):\(String(format: "%02d", sLength % 60))"
            runSetTimer()
        }
    }
    
    @objc func updatePreintervalTimer()
    {
        if pLength > 0
        {
            pLength -= 1
            tempTotalTime -= 1
            currentLength.text = "\(String(format: "%02d", pLength / 60)):\(String(format: "%02d", pLength % 60))"
            totalLength.text = "\(String(format: "%02d", tempTotalTime / 60)):\(String(format: "%02d", tempTotalTime % 60))"
            ap.countdownVoice(length: pLength)
        }
        else
        {
            timer.invalidate()
            preintervalTimerDone = true
            currentLength.text = "\(String(format: "%02d", sLength / 60)):\(String(format: "%02d", sLength % 60))"
            runSetTimer()
        }
    }
    
    func runSetTimer()
    {
        if setTimerDone == false
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSetTimer), userInfo: nil, repeats: true)
            currentLength.textColor = UIColor.systemGreen
            timerAudioDone = false
        }
        else
        {
            currentLength.text = "\(String(format: "%02d", bLength / 60)):\(String(format: "%02d", bLength % 60))"
            runBreakTimer()
        }
    }
    
    @objc func updateSetTimer()
    {
        if sLength > 0 && noOfSets > 0
        {
            sLength -= 1
            tempTotalTime -= 1
            totalLength.text = "\(String(format: "%02d", tempTotalTime / 60)):\(String(format: "%02d", tempTotalTime % 60))"
            currentLength.text = "\(String(format: "%02d", sLength / 60)):\(String(format: "%02d", sLength % 60))"
            ap.countdownVoice(length: sLength)
        }
        else if sLength == 0 && noOfSets > 0
        {
            timer.invalidate()
            sLength = access.setLength
            currentLength.text = "\(String(format: "%02d", bLength / 60)):\(String(format: "%02d", bLength % 60))"
            setTimerDone = true
            breakTimerDone = false
            runBreakTimer()
        }
        else if sLength == 0 && recoveryTimerDone == true && breakTimerDone == false
        {
            timer.invalidate()
            currentLength.text = "\(String(format: "%02d", rLength / 60)):\(String(format: "%02d", rLength % 60))"
            setTimerDone = true
            recoveryTimerDone = false
            runRecoveryTimer()
        }
        else
        {
            timer.invalidate()
            setTimerDone = true
        }
    }
    
    func runBreakTimer()
    {
        if breakTimerDone == false
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
            currentLength.textColor = UIColor.systemOrange
            timerAudioDone = false
        }
        else
        {
            currentLength.text = "\(String(format: "%02d", rLength / 60)):\(String(format: "%02d", pLength % 60))"
            runRecoveryTimer()
        }
    }
    
    @objc func updateBreakTimer()
    {
        if bLength > 0
        {
            bLength -= 1
            tempTotalTime -= 1
            totalLength.text = "\(String(format: "%02d", tempTotalTime / 60)):\(String(format: "%02d", tempTotalTime % 60))"
            currentLength.text = "\(String(format: "%02d", bLength / 60)):\(String(format: "%02d", bLength % 60))"
            ap.countdownVoice(length: bLength)
        }
        else if bLength == 0 && noOfSets - 1 == 0
        {
            timer.invalidate()
            recoveryTimerDone = false
            currentLength.text = "\(String(format: "%02d", rLength / 60)):\(String(format: "%02d", rLength % 60))"
            runRecoveryTimer()
        }
        else
        {
            timer.invalidate()
            noOfSets -= 1
            setsRemainingLabel.text = "\(noOfSets) sets remaining."

            if noOfSets != 0
            {
                currentLength.text = "\(String(format: "%02d", sLength / 60)):\(String(format: "%02d", sLength % 60))"
            }
            
            bLength = access.breakLength
            setTimerDone = false
            breakTimerDone = true
            runSetTimer()
        }
    }
    
    func runRecoveryTimer()
    {
        if recoveryTimerDone == false
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRecoveryTimer), userInfo: nil, repeats: true)
            currentLength.textColor = UIColor.systemBlue
            timerAudioDone = false
        }
    }
    
    @objc func updateRecoveryTimer()
    {
        if rLength > 0
        {
            rLength -= 1
            tempTotalTime -= 1
            totalLength.text = "\(String(format: "%02d", tempTotalTime / 60)):\(String(format: "%02d", tempTotalTime % 60))"
            currentLength.text = "\(String(format: "%02d", rLength / 60)):\(String(format: "%02d", rLength % 60))"
            ap.countdownVoice(length: rLength)
        }
        else
        {
            timer.invalidate()
            ap.synth.speak(ap.intervalDone)
            setsRemainingLabel.text = "\(noOfSets - 1) sets remaining."
            startPauseButton.setTitle("START", for: .normal)
        }
    }
    
    // MARK: Buttons
    
    @IBAction func startPause(_ sender: UIButton)
    {
        if startPauseButton.currentTitle == "START"
        {
            startPauseButton.setTitle("PAUSE", for: .normal)
            
            runPreintervalTimer()
            ap.synth.speak(ap.intervalStarted)
        }
        else if startPauseButton.currentTitle == "PAUSE"
        {
            startPauseButton.setTitle("RESUME", for: .normal)
            
            if pauseTimer == false
            {
                timer.invalidate()
                pauseTimer = true
                ap.synth.speak(ap.intervalPaused)
            }
        }
        else
        {
            startPauseButton.setTitle("PAUSE", for: .normal)
            
            if pauseTimer == true
            {
                runPreintervalTimer()
                pauseTimer = false
                ap.synth.speak(ap.intervalStarted)
            }
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton)
    {
        startPauseButton.setTitle("START", for: .normal)
        
        timer.invalidate()
        ap.synth.speak(ap.intervalStopped)
        
        currentLength.textColor = .none
        timerAudioDone = false
        noOfSets = access.numberOfSets
        noOfRepetitions = access.numberOfRepetitions
        sLength = access.setLength
        rLength = access.recoveryLength
        bLength = access.breakLength
        pLength = access.preintervalLength
        tempTotalTime = totalTime
        
        if access.checkPreinterval()
        {
            tempTime = access.preintervalLength
            
            currentLength.text = "\(String(format: "%02d", tempTime / 60)):\(String(format: "%02d", tempTime % 60))"
        }
        else
        {
            tempTime = access.setLength
            
            currentLength.text = "\(String(format: "%02d", tempTime / 60)):\(String(format: "%02d", tempTime % 60))"
        }
        
        totalLength.text = "\(String(format: "%02d", tempTotalTime / 60)):\(String(format: "%02d", tempTotalTime % 60))"
        setsRemainingLabel.text = "\(noOfSets) sets remaining."
        setTimerDone = false
        preintervalTimerDone = false
        recoveryTimerDone = false
        breakTimerDone = false
    }
}

