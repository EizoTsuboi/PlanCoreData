//
//  CheckViewController.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/09/04.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {
    
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var DateTextField: UITextField!
    @IBOutlet weak var detailNameTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var memberTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    
    
//
//    @IBOutlet weak var planNameLabel: UILabel!
//    @IBOutlet weak var DateTextFeild: UITextField!
//    @IBOutlet weak var detailNameTextField: UITextField!
//    @IBOutlet weak var placeTextField: UITextField!
//    @IBOutlet weak var memberTextFeild: UITextField!
//    @IBOutlet weak var memoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planNameLabel.text = ""
        print("check3")
        DateTextField.text = ""
        detailNameTextField.text = ""
        print("check4")
        placeTextField.text = ""
        memberTextField.text = ""
        print("check5")
        memoTextField.text = ""
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
