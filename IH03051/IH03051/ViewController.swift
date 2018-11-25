//
//  ViewController.swift
//  IH03051
//
//  Created by administrator on 2018/11/16.
//  Copyright © 2018年 taka.tanaka. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var TimeText: UILabel!
    var timer: Timer!
    let settings = UserDefaults.standard
    var piSound:AVAudioPlayer!
    var aramSound:AVAudioPlayer!
    
    var displayTime = 0
    var setTime = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.register(defaults: ["myKey":10])
        setTime = settings.integer(forKey:
            "myKey")
        TimeText.text = "残り\(setTime)秒"
        
        //MP3をセット
        var audioPath = Bundle.main.path(forResource:"pi",ofType:"mp3")!
        var backPlayerUrl = URL(fileURLWithPath: audioPath)
        do{
            piSound = try AVAudioPlayer(contentsOf: backPlayerUrl)
        } catch let error as NSError {
            print(error.code)
        }
        piSound.delegate = self
        
        audioPath = Bundle.main.path(forResource: "aram",ofType:"mp3")!
        backPlayerUrl = URL(fileURLWithPath: audioPath)
        do{
            aramSound = try AVAudioPlayer(contentsOf: backPlayerUrl)
        } catch let error as NSError {
            print(error.code)
        }
        aramSound.delegate = self
    }
    
    // 画面遷移から復帰後、タイマーに値をセットする
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        setTime = settings.integer(forKey:
            "myKey")
        TimeText.text = "残り\(setTime)秒"
    }
    
    // 画面遷移時にタイマーを止める
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    // タイマーを起動
    func startTimer() {
        if let nowTimer = timer{
            if nowTimer.isValid == true{
                return }
        }
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
    }
    
    // タイマーを停止
    func stopTimer() {
        if let nowTimer = timer{
            if nowTimer.isValid == true{
                nowTimer.invalidate()
            }
        }
    }
    
    func displayUpdate() -> Int {
        displayTime = setTime - count
        return displayTime
    }
    
    // タイマーをカウントし表示
    @objc func timerCounter() {
        count += 1
        if displayUpdate() <= 0{
            aramSound.play()
            count = 0
            timer.invalidate()
            TimeText.text = "残り\(setTime)秒"
        } else {
            TimeText.text = "残り\(displayTime)秒"
        }
    }
    @IBAction func StartButton(_ sender: Any) {
        piSound.play()
        startTimer()
    }
    @IBAction func StopButton(_ sender: Any) {
        aramSound.stop()
        stopTimer()
    }
    
}

