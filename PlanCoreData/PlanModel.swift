//
//  Model.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/08/30.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//
import UIKit


struct PlanModel{
    var planName: String?
    var category: NSNumber?
    var detailName: String?
    var memver: String?
    var memo: String?
    var place:String?
    var startDate: Date?
    var startDateTime: Date?
    var endDate: Date?
    var endDateTime: Date?
}

struct TitleViewPlan {
    var planName: String?
    var category: NSNumber?
    var startDate: Date?
    var startDateTime: Date?
    var endDate: Date?
    var endDateTime: Date?
}

class ColorDic {
    let colorDic:[String: UIColor] = [
        "Private": UIColor(hex: "58BE89"),
        "Work": UIColor(hex: "40AAEF"),
        "Study": UIColor(hex: "FDC44F")
    ]
}
