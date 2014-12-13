//
//  PlaySoundsController.swift
//  Pitch Perfect
//
//  Created by Appthority Rocks on 12/12/14.
//  Copyright (c) 2014 Rubydubee. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filepath = receivedAudio.filePathUrl {
            audioEngine = AVAudioEngine()
            audioPlayer = AVAudioPlayer(contentsOfURL: filepath, error: nil)
            audioPlayer.enableRate = true
            audioPlayer.delegate = self
            audioFile = AVAudioFile(forReading: filepath, error: nil)
        } else {
            println("Error finding the audio file")
        }
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithRate(0.5)
    }
    @IBAction func playFast(sender: UIButton) {
        playAudioWithRate(2.0)
    }
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithPitch(1000)
    }
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithPitch(-1000)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        stopButton.hidden = true
    }
    
    func playAudioWithRate(rate: Float) {
        stopButton.hidden = false
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.hidden = false
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.hidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
