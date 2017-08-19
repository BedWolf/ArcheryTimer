//
//  MenuViewController.swift
//  Archery Timer
//
//  Created by BedWolf2000 on 03.07.17.
//  Copyright © 2017 BedWolf. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
//    waiting time matters
    @IBOutlet weak var waitingTimeSlider: UISlider!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    var waitingTime = 10 // current value
    
//    updating the label
    @IBAction func waitingTimeChange(_ sender: UISlider) {
        waitingTime = Int(sender.value)
        if waitingTime < 2 {
            waitingTimeLabel.text = "\(waitingTime) second"
        } else {
            waitingTimeLabel.text = "\(waitingTime) seconds"
        }
    }
    
    
    
//    shooting time matters
    @IBOutlet weak var shootingTimeSlider: UISlider!
    @IBOutlet weak var shootingTimeLabel: UILabel!
    var shootingTime = 240 // current value
    
    //    updating the label
    @IBAction func shootingTimeChange(_ sender: UISlider) {
        shootingTime = Int(sender.value)
        if shootingTime < 2 {
            shootingTimeLabel.text = "\(shootingTime) second"
        } else if shootingTime < 5 && shootingTime >= 1 {
        } else {
            shootingTimeLabel.text = "\(shootingTime) seconds"
        }
    }
    
    
    
//    Last Seconds matters
    @IBOutlet weak var lastSecondsLabel: UILabel!
    var lastSeconds = 30 // current value
    
    //    updating the label
    @IBAction func changeValueLastSeconds(_ sender: UISlider) {
        // if the shooting time is greater than 30 seconds (120 or 240 for ex.) the last seconds are set to 30sec
        // if not, it's 5sec less
        if sender.value > 35 {
            lastSeconds = 30
            lastSecondsLabel.text = "\(lastSeconds) seconds"
        } else {
            lastSeconds = Int(sender.value - 5)
            lastSecondsLabel.text = "\(lastSeconds) seconds"
        }
        
            
    }
    
    
//    preparing the timer
    @IBAction func prepareTimer(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let timerController = segue.destination as! TimerViewController
        timerController.timeInterval1 = waitingTime
        timerController.timeInterval2 = shootingTime
        timerController.lastSeconds = lastSeconds
        timerController.currentTimeInterval = waitingTime
    }
    
    
}

