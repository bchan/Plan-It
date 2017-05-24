//
//  DailyViewController.swift
//  Plan It
//
//  Created on 5/17/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class DailyViewController : UITableViewController {
    
    var today = Day(Date())
    var currentDay: Day?
    
    override func viewWillAppear(_ animated: Bool) {
        if let day = currentDay {
            navigationItem.title = "\(day.month) \(String(day.dateNumber))"
        } else {
            navigationItem.title = "\(today.month) \(String(today.dateNumber))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
