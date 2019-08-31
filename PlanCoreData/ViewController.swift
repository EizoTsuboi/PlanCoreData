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
    
    var plans: [Plan] = []
    var imageDic: [String: UIImage] = [
        "Private": UIImage(named: "private")!,
        "Work": UIImage(named: "work")!
    ]
    var setDateStr: String = ""
    
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
        getData()
        planTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planTableView.dequeueReusableCell(withIdentifier: "CostomCell", for: indexPath) as! CostomTableViewCell
        let plan = plans[indexPath.row]
        
        setDate(plan)
        
        cell.setData(categoryImage: imageDic[plan.category!], planNameLabel: plan.planName, planDateLabel: setDateStr )
        return cell
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            plans = try context.fetch(Plan.fetchRequest())
            print("読み込みOK")
        }catch{
            print("読み込みエラー")
        }
    }
    
    func setDate(_ plan: Plan){
        //表示するDateの処理
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        let dateFormatter2: DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm"
        let startDate = dateFormatter1.string(from: plan.startDate!)
        let endDate = dateFormatter1.string(from: plan.endDate!)
        let startDateTime = dateFormatter2.string(from: plan.startDateTime!)
        let endDateTime = dateFormatter2.string(from: plan.endDateTime!)
        if startDate == endDate{
            if startDateTime == ""{
                setDateStr = "\(startDate)"
            }else{
                setDateStr = "\(startDate)\n\(startDateTime)-\(endDateTime)"
            }
        }else{
            if startDateTime == ""{
                setDateStr = "\(startDate)-\(endDate)"
            }else{
                setDateStr = "\(startDate)-\(endDate)\n\(startDateTime)-\(endDateTime)"
            }
        }
    }

}

