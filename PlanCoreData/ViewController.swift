//
//  ViewController.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/08/30.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var plans: [TitleViewPlan] = []
    let service = Service()

    @IBOutlet weak var planTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planTableView.delegate = self
        planTableView.dataSource = self
        
        let nib = UINib(nibName: "CostomTableViewCell", bundle: nil)
        self.planTableView.register(nib, forCellReuseIdentifier: "CostomCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plans = self.service.getTitleViewPlans()
        planTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planTableView.dequeueReusableCell(withIdentifier: "CostomCell", for: indexPath) as! CostomTableViewCell
        let plan = plans[indexPath.row]
        
        //表示する画像をServiceクラスのメソッドから返す。category(Int16) -> UIImage
        let setImage: UIImage = self.service.setCategoryImage(planCategory: plan.category!)
        let setStartDate: String = self.service.setStartDate(plan: plan)
        let setEndDate: String = self.service.setEndDate(plan: plan)
        
        //CostomCellにplanをset
        cell.setData(categoryImage: setImage, planNameLabel: plan.planName, planDateLabel: setStartDate )
        return cell
    }
    


}

