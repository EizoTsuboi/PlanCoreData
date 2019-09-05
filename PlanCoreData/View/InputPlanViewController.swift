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
    var categoryList: [String] = []
    let service = Service()
    var editPlanId: Int = 0

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
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        //背景の設定
        var selectRow = categoryPickerView.selectedRow(inComponent: 0)
        self.view.backgroundColor =  self.service.getColorFromPickerRow(PickerRow: selectRow)
        
        //TimeDatePickerを非表示
        startTimeDatePicker.isHidden = true
        endTimeDatePicker.isHidden = true
        
        errorLabel.isHidden = true
        
        //DatePickerの値を現在にする
        let now = NSDate()
        startDatePicker.date = now as Date
        startTimeDatePicker.date = now as Date
        endDatePicker.date = now as Date
        endTimeDatePicker.date = now as Date
        
        //CheckViewから遷移してきたとき
        if plan.planName != nil{
            planNameTextField.text = plan.planName
            categoryPickerView.selectRow(Int(plan.category!), inComponent: 0, animated: true)
            detailNameTextField.text = plan.detailName
            if let date = plan.startDate{
                startDatePicker.date = date
            }
            if let date = plan.startDateTime{
                startTimeDatePicker.date = date
            }
            if let date = plan.endDate{
                endDatePicker.date = date
            }
            if let date = plan.endDateTime{
                endTimeDatePicker.date = date
            }
            placeTextField.text = plan.place
            memberTextField.text = plan.memver
            memoTextField.text = plan.memo
            
            selectRow = categoryPickerView.selectedRow(inComponent: 0)
            self.view.backgroundColor =  self.service.getColorFromPickerRow(PickerRow: selectRow)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        //ピッカーに表示するカテゴリリストを取得
        categoryList = self.service.getCategoryList()
    }
    
    @IBAction func okButton(_ sender: Any) {
        //planNameが未入力の場合処理をせずエラーメッセージを返す
        if planNameTextField.text == "" {
            errorLabel.isHidden = false
            return
        }
        //planインスタンスに何も入っていないとき（新規）
        if plan.planName == nil{
            setData()
            print("確認2")
            self.service.inputPlan(inputPlan: plan)
        }else if plan.planName != nil{
            //planインスタンスにすでにデータが入っているとき（更新）
            setData()
            print("確認3")
            self.service.editPlan(inputPlan: plan,Index: editPlanId)
        }
        //入力した内容をリセット
        resetData()
        print("確認4")
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
        //pickerのrow(=CategoryNum)からUIColorを取得し、背景に設定
        self.view.backgroundColor =  self.service.getColorFromPickerRow(PickerRow: row)
        
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
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "startNC")
        present(startVC!, animated: true, completion: nil)
    }
    
    //入力されたデータをplanインスタンスにセット
    func setData(){
        plan.planName = planNameTextField.text
        plan.category = NSNumber(value: categoryPickerView.selectedRow(inComponent: 0))
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
    }

}
