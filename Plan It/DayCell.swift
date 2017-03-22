//
//  DayCell.swift
//  Plan It
//
//  Created by Benjamin Chan on 3/13/17.
//  Copyright © 2017 Benjamin Chan. All rights reserved.
//

import Foundation
import UIKit

class DayCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayOfTheWeek: UILabel!
    @IBOutlet var previewLabel: UILabel!

    var date = NSDate()

}
