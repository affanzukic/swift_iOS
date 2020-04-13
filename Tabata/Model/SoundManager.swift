//
//  SoundManager.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-13.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager
{
    var _Sound: AVAudioPlayer!
    var url: URL?
    
    init(fileName: String)
    {
        url = Bundle.main.url(forResource: fileName, withExtension: "wav")
    }
    
    func playSound(stopAudio: Bool)
    {
        if (url == nil)
        {
            print("Couldn't find file \(String(describing: _Sound))")
        }
        
        do
        {
            _Sound = try AVAudioPlayer(contentsOf: url!, fileTypeHint: nil)
        }
        catch let error
        {
            print(error.localizedDescription)
        }
        
        if _Sound == nil
        {
            print("Couldn't create sound instance!")
        }
        
        if stopAudio == false
        {
        _Sound.prepareToPlay()
        _Sound.numberOfLoops = -1
        _Sound.play()
            
        }
        else
        {
            _Sound.stop()
        }
    }
}
