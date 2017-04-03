//
//  WeeklyViewController.swift
//  Plan It
//
//  Created on 3/08/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class WeeklyViewController: UITableViewController {
        
    var dayStore: DayStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayStore.allDays.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = dayStore.allDays[indexPath.row]
        
        cell.textLabel?.text = String(item.dateNumber)
        cell.detailTextLabel?.text = item.dayOfWeek
        
        return cell
    }



    
}


//    @IBAction func addNewItem(_ sender: AnyObject) {
//        let newItem = itemStore.createItem()
//        if let index = itemStore.allItems.index(of: newItem) {
//            let indexPath = IndexPath(row: index, section: 0)
//
//            tableView.insertRows(at: [indexPath], with: .automatic)
//        }
//    }

//    @IBAction func toggleEditingMode(_ sender: AnyObject) {
//        // If you are currently in editing mode...
//        if isEditing {
//            // Change text of button to inform user of state
//            sender.setTitle("Edit", for: UIControlState())
//
//            // Turn off editing mode
//            setEditing(false, animated: true)
//        }
//        else {
//            // Change text of button to inform user of state
//            sender.setTitle("Done", for: UIControlState())
//
//            // Enter editing mode
//            setEditing(true, animated: true)
//        }
//    }
