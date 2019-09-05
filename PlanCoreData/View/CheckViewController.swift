//
//  CheckViewController.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/09/04.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {
    var plan = PlanModel()
    let service = Service()
    var id: Int = 0
    
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var dateNameLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = self.service.getColorFromCategory(plan: plan)
        
        let setDate: String = self.service.setDate(plan: plan)
        planNameLabel.text = plan.planName
        dateNameLabel.text = setDate
        detailNameLabel.text = plan.detailName
        placeLabel.text = plan.place
        memberLabel.text = plan.memver
        memoLabel.text = plan.memo
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    //編集する時のinputViewに渡すデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue") {
            let inputPlanViewController: InputPlanViewController = segue.destination as! InputPlanViewController
            
            inputPlanViewController.plan = self.plan
            inputPlanViewController.editPlanId = self.id
            
        }
    }
    
}
