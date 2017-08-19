//
//  TimerViewController.swift
//  Archery Timer
//
//  Created by BedWolf2000 on 22.07.17.
//  Copyright © 2017 BedWolf. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    let colors = [UIColor.green, UIColor.orange, UIColor.red, UIColor.white]
    var timeInterval1 = Int() // first interval (red light)
    var timeInterval2 = Int() // time of shooting and green light
    var lastSeconds = Int() // last seconds and orange light
    var currentTimeInterval = Int()
    
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()
    var seconds = 60 // seconds for the timer
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBAction func start(_ sender: Any) {
        archeryTimer()
    }
    
    override func viewDidLoad() {
        
        preparePlayer()
    }
    
    func preparePlayer() {
        do {
            let audioPath = Bundle.main.path(forResource: "buzzer", ofType: ".wav")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch {
            // ERROR
        }
    }
    
    func changeColor(index: Int) {
        self.view.backgroundColor = self.colors[index]
    }
    
    
    @objc func changeTimeValue() {
        // minus one second, update the label
        seconds -= 1
        self.time.text = "\(seconds)"
        
        // if we are in the waiting time, it whistle once at 0sec and change to green
        // to recognize the waiting time we ask the currentTimeInterval
        if currentTimeInterval == timeInterval1 {
            if seconds == 0 {
                time.text = String(timeInterval2) // updating the time label
                // updating the color (green) and the seconds
                changeColor(index: 0)
                seconds = timeInterval2
                currentTimeInterval = timeInterval2
                // whistle once
                audioPlayer.numberOfLoops = 0
                audioPlayer.play()
            }
            
        }
            // if we are in the shooting time, it whistle three times at 0sec and tells to get your arrows
            // at 30seconds (or any last seconds), the color changes to orange
            // to recognize the shooting time, we ask the current time interval
        else if currentTimeInterval == timeInterval2 {
            
            if seconds == 0 {
                timer.invalidate() //stops the timer
                // whistle three times
                audioPlayer.numberOfLoops = 2
                audioPlayer.play()
                // changes the label and the color to white
                self.time.text = "Arrows !"
                changeColor(index: 3)
                startButton.isHidden = false // shows again the start button
                //stops the audio player when it's finished
                if !audioPlayer.isPlaying {
                    audioPlayer.stop()
                }
            }
            else if seconds == lastSeconds {
                changeColor(index: 1) //change the color
            }
        }
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeTimeValue), userInfo: nil, repeats: true)
    }
    
    func archeryTimer() {
        
        // timer for the first interval, updating the current interval, the timer's seconds and the time label
        currentTimeInterval = timeInterval1
        seconds = timeInterval1
        time.text = String(timeInterval1)
        
        // make it red and hide the button
        changeColor(index: 2)
        startButton.isHidden = true
        
        //whistle twice
        audioPlayer.numberOfLoops = 1
        audioPlayer.play()
        
        // start the countdown
        startTimer()
        
    }
}
