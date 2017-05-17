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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(today.month) \(String(today.dateNumber))"

        
        // Get the height of the status bar
        //        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        //
        //        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        //        tableView.contentInset = insets
        //        tableView.scrollIndicatorInsets = insets
        
    }
    
}
