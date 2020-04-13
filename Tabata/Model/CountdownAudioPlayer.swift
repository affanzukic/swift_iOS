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
    var player: AVAudioPlayer!
    
    mutating func loadAudio()
    {
        let pathToSound = Bundle.main.path(forResource: "countdownBeep", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do
        {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        }
        catch
        {
        }
    }
}
