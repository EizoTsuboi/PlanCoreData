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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
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
        print("確認4")
        //インプットされたinputPlan(struct: PlanModel)をNSManegedObjectに入れる
        plan.planName = inputPlan.planName
        plan.category = inputPlan.category
        plan.detailName = inputPlan.detailName
        plan.startDateTime = inputPlan.startDateTime
        plan.startDate = inputPlan.startDate
        print("確認5")
        plan.endDate = inputPlan.endDate
        plan.endDateTime = inputPlan.endDateTime
        plan.member = inputPlan.memver
        plan.memo = inputPlan.memo
        plan.place = inputPlan.place
        print("確認6")
        //NSManegedObjectContext に NSManegedObjectを格納（保存）
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("確認7")
    }
    
    //予定の更新
    func editPlan(inputPlan: PlanModel, Index: Int){
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        // startdateの順にソートする命令の追加（ascending(sort),selector,comparatorの設定が不要であれば、記載なしでOK）
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        //NSManegedObjectが入るオブジェクト
        let records: [Plan]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Plan]
        }catch{
            print("エラー1")
        }
        
        let record = records[Index]
        print("確認9")
        //インプットされたinputPlan(struct: PlanModel)をNSManegedObjectに入れる
        record.planName = inputPlan.planName
        record.category = inputPlan.category
        record.detailName = inputPlan.detailName
        record.startDateTime = inputPlan.startDateTime
        record.startDate = inputPlan.startDate
        print("確認10")
        record.endDate = inputPlan.endDate
        record.endDateTime = inputPlan.endDateTime
        record.member = inputPlan.memver
        record.memo = inputPlan.memo
        record.place = inputPlan.place
        print("確認11")
        //NSManegedObjectContext に NSManegedObjectを格納（保存）
        do{
            try! context.save()
        }
        print("確認12")
    }
    //選択したセルを削除
    func deleteCell(Index: Int){
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        // startdateの順にソートする命令の追加（ascending(sort),selector,comparatorの設定が不要であれば、記載なしでOK）
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        //NSManegedObjectが入るオブジェクト
        let records: [Plan]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Plan]
        }catch{
            print("エラー1")
        }
        
        let record = records[Index]
        context.delete(record)
        do{
            try context.save()
        }catch{
            print("エラー2")
        }
    }
    
    //セルにセットする UIImage  <- category番号
    func setCategoryImage(planCategory:NSNumber) -> UIImage{
        switch planCategory {
        case 0:
            return UIImage(named: "private")!
        case 1:
            return UIImage(named: "work")!
        case 2:
            return UIImage(named: "study")!
        default:
            return UIImage()
        }
    }
    
    //セルに表示するため、DateをStringに（タイトル画面用）
    func setDate(plan: TitleViewPlan) -> String{
        //Dateがセットされていない可能性があるためオプショナル型
        let startDate: Date? = plan.startDate
        let startDateTime: Date? = plan.startDateTime
        let endDate: Date? = plan.endDate
        let endDateTime: Date? = plan.endDateTime
        
        //日付Formatter
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        //時間Formatter
        let dateFormatter2: DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm"
        
        if endDate == nil && startDateTime == nil{
            return dateFormatter1.string(from: startDate!)
        }else if endDate == nil{
            return "\(dateFormatter1.string(from: startDate!))\n\(dateFormatter2.string(from: startDateTime!))"
        }else if startDateTime == nil{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))"
        }else if endDateTime == nil{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))\n\(dateFormatter2.string(from: startDateTime!))"
        }else{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))\n\(dateFormatter2.string(from: startDateTime!)) - \(dateFormatter2.string(from: endDateTime!))"
        }
    }
    
    //セルに表示するため、DateをStringに （CheckView用)
    func setDate(plan: PlanModel) -> String{
        //Dateがセットされていない可能性があるためオプショナル型
        let startDate: Date? = plan.startDate
        let startDateTime: Date? = plan.startDateTime
        let endDate: Date? = plan.endDate
        let endDateTime: Date? = plan.endDateTime
        
        //日付Formatter
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        //時間Formatter
        let dateFormatter2: DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm"
        
        if endDate == nil && startDateTime == nil{
            return dateFormatter1.string(from: startDate!)
        }else if endDate == nil{
            return "\(dateFormatter1.string(from: startDate!))\n\(dateFormatter2.string(from: startDateTime!))"
        }else if startDateTime == nil{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))"
        }else if endDateTime == nil{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))\n\(dateFormatter2.string(from: startDateTime!))"
        }else{
            return "\(dateFormatter1.string(from: startDate!)) - \(dateFormatter1.string(from: endDate!))\n\(dateFormatter2.string(from: startDateTime!)) - \(dateFormatter2.string(from: endDateTime!))"
        }
    }
    
    //ピッカーに表示するカテゴリリストをピックアップ
    func getCategoryList() -> [String]{
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        //NSManegedObjectが入るオブジェクト
        let records: [Category]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Category]
        }
        if records.isEmpty{
            return []
        }
        
        var Lists:[String] = []
        for record in records {
            Lists.append(record.categoryname!)
        }
        
        return Lists
    }
    
    //PickerViewの行番号からCategoryNameを取得->UIColorを返す
    func getColorFromPickerRow(PickerRow: Int) -> UIColor{
        let colorDic = ColorDic()
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        //NSManegedObjectが入るオブジェクト
        let records: [Category]
        do {//context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Category]
        }
        
        var categoryname:String = ""
        for record in records {
            if record.id == PickerRow{
                categoryname = record.categoryname!
            }
        }
        let getColor: UIColor = colorDic.colorDic[categoryname]!
        
        return getColor
    }
    
    func getColorFromCategory(plan: TitleViewPlan) -> UIColor{
        let colorDic = ColorDic()
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        //NSManegedObjectが入るオブジェクト
        let records: [Category]
        do {//context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Category]
        }
        var categoryname:String = ""
        for record in records {
            if record.id == Int64(plan.category!){
                categoryname = record.categoryname!
            }
        }
        let getColor: UIColor = colorDic.colorDic[categoryname]!
        return getColor
    }
    func getColorFromCategory(plan: PlanModel) -> UIColor{
        let colorDic = ColorDic()
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        //NSManegedObjectが入るオブジェクト
        let records: [Category]
        do {//context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Category]
        }
        var categoryname:String = ""
        for record in records {
            if record.id == Int64(plan.category!){
                categoryname = record.categoryname!
            }
        }
        let getColor: UIColor = colorDic.colorDic[categoryname]!
        return getColor
    }
    
    //選択したセル（indexpath.rowにあたるオブジェクト）を返す
    func getPlanFromIndex(Index: Int) -> PlanModel{
        // フェッチリクエスト(検索命令)の生成
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        // startdateの順にソートする命令の追加（ascending(sort),selector,comparatorの設定が不要であれば、記載なしでOK）
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        //NSManegedObjectが入るオブジェクト
        let records: [Plan]
        do {
            //context(NSManegedObjectContext)に格納されているNSmangedObjectをNSFetchRequestの命令によって出してきてrecordsに入れる
            //records = NSManegedObject
            records = try! context.fetch(fetchRequest) as! [Plan]
        }
        if records.isEmpty{
            return PlanModel()
        }
        //Indexに当たるデータを選択
        let record: Plan = records[Index]
        //PlanModel(Struct)をインスタンス化したオブジェクトにNSManegedObject(record)を入れる
        var plan: PlanModel = PlanModel()
        
        plan.planName = record.planName
        plan.category = record.category
        plan.detailName = record.detailName
        plan.memver = record.member
        plan.memo = record.memo
        plan.place = record.place
        plan.startDate = record.startDate
        plan.startDateTime = record.startDateTime
        plan.endDate = record.endDate
        plan.endDateTime = record.endDateTime
        return plan
    }
}
