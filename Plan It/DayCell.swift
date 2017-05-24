//
//  DayCell.swift
//  Plan It
//
//  Created on 3/13/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class DayCell : UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayOfTheWeek: UILabel!
    //@IBOutlet var previewLabel: UILabel!

    var date = NSDate()

}
