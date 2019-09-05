//
//  CostomTableViewCell.swift
//  PlanCoreData
//
//  Created by 坪井衛三 on 2019/08/30.
//  Copyright © 2019 Eizo Tsuboi. All rights reserved.
//

import UIKit

class CostomTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planDateLabel: UILabel!
    @IBOutlet weak var trushIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(categoryImage: UIImage?, planNameLabel: String?, planDateLabel: String?) {
        self.categoryImageView.image = categoryImage
        self.planNameLabel.text = planNameLabel
        self.planDateLabel.text = planDateLabel
        
        // Configure the view for the selected state
    }
    
}
