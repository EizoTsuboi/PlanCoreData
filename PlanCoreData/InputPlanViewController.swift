//
//  InputPlanViewController.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/08/30.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import UIKit

class InputPlanViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var plan = PlanModel()
    let categoryList = CategoryList().categoryList
    let service = Service()
    var selectcategory: NSNumber = 0
    

    @IBOutlet weak var planNameTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var detailNameTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var memberTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        startTimeDatePicker.isHidden = true
        endTimeDatePicker.isHidden = true
        
        //DatePickerの値を現在にする
        let now = NSDate()
        startDatePicker.date = now as Date
        startTimeDatePicker.date = now as Date
        endDatePicker.date = now as Date
        endTimeDatePicker.date = now as Date
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
    }
    
    @IBAction func okButton(_ sender: Any) {

        plan.planName = planNameTextField.text
        plan.category = selectcategory
        plan.detailName = detailNameTextField.text
        plan.startDate = startDatePicker.date
        plan.memver = memoTextField.text
        plan.memo = memoTextField.text
        plan.place = placeTextField.text
        
        if endDatePicker.date <= startDatePicker.date{
            plan.endDate = nil
        }else{
            plan.endDate = endDatePicker.date
        }
        print("確認1")
        if startTimeDatePicker.isHidden{
            plan.startDateTime = nil
            plan.endDateTime = nil
        }else{
            if endTimeDatePicker.isHidden{
                plan.startDateTime = startTimeDatePicker.date
                plan.endDateTime = nil
            }else{
                plan.startDateTime = startTimeDatePicker.date
                plan.endDateTime = endTimeDatePicker.date
            }
        }
        print("確認2")
        self.service.inputPlan(inputPlan: plan)
        print("確認3")
        //入力した内容をリセット
        resetData()
        print("確認8")
        //ホーム画面に移動
        moveVC()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //入力した内容をリセット
        resetData()
        //ホーム画面に移動
        moveVC()
    }
    
    //categoryPickerの設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    // ピッカーが動いたとき
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectcategory = NSNumber(value: row)
    }
    
    //Tim on/offボタンを押したときにdatepickerを表示
    @IBAction func startTImeButton(_ sender: Any) {
        if startTimeDatePicker.isHidden {
            startTimeDatePicker.isHidden = false
        }else{
            startTimeDatePicker.isHidden = true
        }
    }
    @IBAction func endTimeButton(_ sender: Any) {
        if endTimeDatePicker.isHidden {
            endTimeDatePicker.isHidden = false
        }else{
            endTimeDatePicker.isHidden = true
        }
    }
    func resetData(){
        planNameTextField.text = ""
        categoryPickerView.selectedRow(inComponent: 0)
        detailNameTextField.text = ""
        memoTextField.text = ""
        memoTextField.text = ""
        placeTextField.text = ""
    }
    func moveVC(){
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "startView")
        present(startVC!, animated: true, completion: nil)
    }

}
