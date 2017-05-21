//
//  EventCell.swift
//  Plan It
//
//  Created on 5/18/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class EventCell : UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var importantLabel: UILabel!
    @IBOutlet var alarmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        dateLabel.adjustsFontForContentSizeCategory = true
        locationLabel.adjustsFontForContentSizeCategory = true
        importantLabel.adjustsFontForContentSizeCategory = true
        alarmLabel.adjustsFontForContentSizeCategory = true
    }
}
