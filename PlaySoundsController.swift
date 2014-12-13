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

    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filepath = receivedAudio.filePathUrl {
            audioPlayer = AVAudioPlayer(contentsOfURL: filepath, error: nil)
            audioPlayer.enableRate = true
            audioPlayer.delegate = self
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
        playAudio(0.5)
    }
    @IBAction func playFast(sender: UIButton) {
        playAudio(2.0)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        stopButton.hidden = true
    }
    
    func playAudio(rate: Float) {
        stopButton.hidden = false
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
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
