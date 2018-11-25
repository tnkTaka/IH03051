//
//  TimeSettingViewController.swift
//  IH03051
//
//  Created by administrator on 2018/11/16.
//  Copyright © 2018年 taka.tanaka. All rights reserved.
//

import UIKit

class TimeSettingViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource{
    var setNum = 10
    let settings = UserDefaults.standard
    let dataList = ["10", "20", "30", "40", "50", "60"]

    @IBOutlet weak var PickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.delegate = self
        PickerView.dataSource = self
        PickerView.showsSelectionIndicator = true;
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        setNum = Int(dataList[row])!
        print(setNum)
    }
    
    @IBAction func DecisionButton(_ sender: Any) {
        settings.setValue(setNum, forKey: "myKey")
        settings.synchronize()
        _=navigationController?.popViewController(animated: true)
    }
    
}
