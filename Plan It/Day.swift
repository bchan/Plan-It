//
//  Day.swift
//  Plan It
//
//  Created by Benjamin Chan on 3/15/17.
//  Copyright © 2017 Benjamin Chan. All rights reserved.
//

import Foundation
import UIKit

class Day: NSObject {
    
    let date: NSDate
    
    init(date: String) {
        let d = DateFormatter()
        self.date = d.date(from: date)! as NSDate
    }
    
    
}
