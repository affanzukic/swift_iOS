//
//  CountdownAudioPlayer.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-13.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation
import AVFoundation

struct CountdownAudioPlayer
{
    var synth = AVSpeechSynthesizer()
    var one: AVSpeechUtterance = AVSpeechUtterance(string: "One")
    var two: AVSpeechUtterance = AVSpeechUtterance(string: "Two")
    var three: AVSpeechUtterance = AVSpeechUtterance(string: "Three")
    var intervalStarted: AVSpeechUtterance = AVSpeechUtterance(string: "Interval started")
    var intervalPaused: AVSpeechUtterance = AVSpeechUtterance(string: "Interval paused")
    var intervalStopped: AVSpeechUtterance = AVSpeechUtterance(string: "Interval stopped")
    var intervalDone: AVSpeechUtterance = AVSpeechUtterance(string: "Interval done")
    
    mutating func setUpVoice()
    {
        one.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        one.voice = AVSpeechSynthesisVoice(language: "en-US")
        one.volume = 100.0
        
        two.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        two.voice = AVSpeechSynthesisVoice(language: "en-US")
        two.volume = 100.0
        
        three.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        three.voice = AVSpeechSynthesisVoice(language: "en-US")
        three.volume = 100.0
        
        intervalStarted.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        intervalStarted.voice = AVSpeechSynthesisVoice(language: "en-US")
        intervalStarted.volume = 100.0
        
        intervalPaused.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        intervalPaused.voice = AVSpeechSynthesisVoice(language: "en-US")
        intervalPaused.volume = 100.0
        
        intervalStopped.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        intervalStopped.voice = AVSpeechSynthesisVoice(language: "en-US")
        intervalStopped.volume = 100.0
        
        intervalDone.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        intervalDone.voice = AVSpeechSynthesisVoice(language: "en-US")
        intervalDone.volume = 100.0
    }
    
    func countdownVoice(length: Int)
    {
        if length == 3
        {
            synth.speak(three)
        }
        if length == 2
        {
            synth.speak(two)
        }
        if length == 1
        {
            synth.speak(one)
        }
    }
}
