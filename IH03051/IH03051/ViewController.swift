//
//  ViewController.swift
//  IH03051
//
//  Created by administrator on 2018/11/16.
//  Copyright © 2018年 taka.tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    var count = 0
    
    var startTime = Date()
    var setTime = 10;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func startTimer() {
        if timer != nil{
            // timerが起動中なら一旦破棄
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
        
        startTime = Date()
    }
    
    func displayUpdate() -> Int {
        let currentTime = Date().timeIntervalSince(startTime)
        count = setTime - (Int)(fmod(currentTime, 60))
        return count
    }
    
    @objc func timerCounter() {
        if displayUpdate() <= 0{
            count = 0
            timer.invalidate()
        }
        
        print(count)
    }
}

