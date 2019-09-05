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
    var plan: PlanModel = PlanModel()
    let service = Service()
    var selectId: Int = 0

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
        
        //セルの背景を設定（planのCategory -> CategoryName -> UIColorを取得）
        cell.backgroundColor = self.service.getColorFromCategory(plan: plan)
        
        //表示する画像をServiceクラスのメソッドから返す。category(Int16) -> UIImage
        let setImage: UIImage = self.service.setCategoryImage(planCategory: plan.category!)
        let setDate: String = self.service.setDate(plan: plan)
        
        //ゴミ箱imageをタップした時の処理を設定（gestureを設定）
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taptrushIcon))
        cell.trushIcon.addGestureRecognizer(tapGesture)
        cell.trushIcon.isUserInteractionEnabled = true
        cell.trushIcon.tag = indexPath.row
        
        //CostomCellにplanをset
        cell.setData(categoryImage: setImage, planNameLabel: plan.planName, planDateLabel: setDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexPath.row番号のPlanModelオブジェクトを持ってくる
        plan = self.service.getPlanFromIndex(Index: indexPath.row)
        selectId = indexPath.row
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cellSegue") {
            let checkViewController: CheckViewController = segue.destination as! CheckViewController
            
            checkViewController.plan = self.plan
            checkViewController.id = selectId

        }
    }
    
    @objc func taptrushIcon(gestureRecognizer: UITapGestureRecognizer) {
        let row = gestureRecognizer.view?.tag
        self.service.deleteCell(Index: row!)
        print("delete終了")
        plans = self.service.getTitleViewPlans()
        planTableView.reloadData()
        print("delete後読み込み")
    }


}

