//
//  Service.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/08/31.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Service{
    //NSManagedObjectContextの設定。ManagedObject（データ）が格納されているオブジェクト。
    //NSManegedObjectの読み込み、書き込みのために用意
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //全ての予定
    func getAllPlans() -> [PlanModel]{
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        //NSManegedObjectが入るオブジェクト
        let records: [Plan]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //∴records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Plan]
            print("読み込み成功1")
        }
        
        if records.isEmpty{
            return []
        }
        //PlanModel(Struct)をインスタンス化したオブジェクトにNSManegedObject(records)を1レコードづつ入れる
        var plans: [PlanModel] = []
        for record in records {
            var plan: PlanModel = PlanModel()
            plan.planName = record.planName
            plan.category = record.category
            plan.detailName = record.detailName
            plan.memver = record.member
            plan.place = record.place
            plan.memo = record.memo
            plan.startDate = record.startDate
            plan.startDateTime = record.startDateTime
            plan.endDate = record.endDate
            plan.endDateTime = record.endDateTime
            
            plans.append(plan)
        }
        return plans
    }
    
    //Titleに表示する予定
    func getTitleViewPlans() -> [TitleViewPlan]{
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        // startdateの順にソートする命令の追加（ascending(sort),selector,comparatorの設定が不要であれば、記載なしでOK）
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startdate", ascending: true)]
        //NSManegedObjectが入るオブジェクト
        let records: [Plan]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Plan]
        }
        if records.isEmpty{
            return []
        }
        //PlanModel(Struct)をインスタンス化したオブジェクトにNSManegedObject(records)を1レコードづつ入れる
        //[!確認!]何故entity:PlanのCategoryだけオプショナル型ではないのか
        var plans: [TitleViewPlan] = []
        for record in records {
            var plan: TitleViewPlan = TitleViewPlan()
            plan.planName = record.planName
            plan.category = record.category
            plan.startDate = record.startDate
            plan.startDateTime = record.startDateTime
            plan.endDate = record.endDate
            plan.endDateTime = record.endDateTime
            
            plans.append(plan)
        }
        return plans
    }
    
    //予定のインプット
    func inputPlan(inputPlan: PlanModel){
        //NSManagedObject Plan(entity)のインスタンス化
        let plan = Plan(context: context)
        
        //インプットされたinputPlan(struct: PlanModel)をNSManegedObjectに入れる
        plan.planName = inputPlan.planName
        plan.category = inputPlan.category
        plan.detailName = inputPlan.detailName
        plan.startDateTime = inputPlan.startDateTime
        plan.startDate = inputPlan.startDate
        plan.endDate = inputPlan.endDate
        plan.endDateTime = inputPlan.endDateTime
        plan.member = inputPlan.memver
        plan.memo = inputPlan.memo
        plan.place = inputPlan.place
        
        //NSManegedObjectContext に NSManegedObjectを格納（保存）
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    //セルにセットする UIImage  <- category番号
    func setCategoryImage(planCategory:NSNumber) -> UIImage{
        switch planCategory {
        case 0:
            return UIImage(named: "private")!
        case 1:
            return UIImage(named: "work")!
        default:
            return UIImage()
        }
    }
    
    //セルにセットするStartDateをStringに （セルはStartDateとEndDateの2つにLabelが分かれている)
    func setStartDate(plan: TitleViewPlan) -> String{
        //Dateがセットされていない可能性があるためオプショナル型
        let startDate: Date? = plan.startDate
        let startDateTime: Date? = plan.startDateTime

        //日付Formatter
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        //時間Formatter
        let dateFormatter2: DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm"
        
        if startDateTime == nil{
            return dateFormatter1.string(from: startDate!)
        }else{
            return dateFormatter1.string(from: startDate!) + "\n" + dateFormatter2.string(from: startDateTime!)
        }
    }
    
    //セルにセットするEndDateをStringに （セルはStartDateとEndDateの2つにLabelが分かれている)
    func setEndDate(plan: TitleViewPlan) -> String{
        //Dateがセットされていない可能性があるためオプショナル型
        let endDate: Date? = plan.endDate
        let endDateTime: Date? = plan.endDateTime
        
        //日付Formatter
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        //時間Formatter
        let dateFormatter2: DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm"
        
        if endDate == nil && endDateTime == nil{
            return ""
        }else if endDateTime == nil{
            return " - \(dateFormatter1.string(from: endDate!))"
        }else{
            return " - \(dateFormatter1.string(from: endDate!))\n - \(dateFormatter2.string(from: endDateTime!))"
        }
    }
}
