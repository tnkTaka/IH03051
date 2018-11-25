//
//  StopWatchController.swift
//  IH03051
//
//  Created by administrator on 2018/11/26.
//  Copyright © 2018年 taka.tanaka. All rights reserved.
//

import UIKit

class StopWatchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var RapResetButton: UIButton!
    
    var rapTime: [String] = []

    var timer: Timer!
    var count = 1
    
    var runningFlg = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rapTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = "ラップ"+String(indexPath.row+1)+": "+rapTime[indexPath.row]
        cell.detailTextLabel?.text = String(rapTime[indexPath.row])
        return cell
    }
    
    // タイマーを起動
    func startTimer() {
        if let nowTimer = timer{
            if nowTimer.isValid == true{
                return
            }
        }
        runningFlg = true
        StartStopButton.setTitle("停止", for: UIControl.State.normal)
        StartStopButton.backgroundColor = UIColor.red
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
    }
    
    // タイマーを停止
    func stopTimer() {
        if let nowTimer = timer{
            if nowTimer.isValid == true{
                runningFlg = false
                nowTimer.invalidate()
            }
        }
    }

    // タイマーをカウントし表示
    @objc func timerCounter() {
        count += 1
        let ms = count % 100
        let s = (count - ms) / 100 % 60
        let m = (count - s - ms) / 6000 % 3600
        Label.text = String (format: "%02d:%02d.%02d", m,s,ms)
    }
    
    @IBAction func StartStopButton(_ sender: Any) {
        if runningFlg {
            stopTimer()
            StartStopButton.setTitle("開始", for: UIControl.State.normal)
            StartStopButton.backgroundColor = UIColor.green
            RapResetButton.setTitle("リセット", for: UIControl.State.normal)
            runningFlg = false
        }else{
            RapResetButton.setTitle("ラップ", for: UIControl.State.normal)
            startTimer()
        }
    }
    
    @IBAction func RapResetButton(_ sender: Any) {
        if runningFlg {
            rapTime.append(Label.text!)
            tableView.reloadData()
        }else{
            RapResetButton.setTitle("ラップ", for: UIControl.State.normal)
            count = 0
            Label.text="00:00.00"
            rapTime = []
            tableView.reloadData()
        }
    }
    
}
