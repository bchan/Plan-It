//
//  WeeklyViewController.swift
//  Plan It
//
//  Created by Benjamin Chan on 3/8/17.
//  Copyright © 2017 Benjamin Chan. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class WeeklyViewController: UITableViewController {
    
    var daysOfTheWeek = [Day]()
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        // Create a new Item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table.
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: AnyObject) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: UIControlState())
            
            // Turn off editing mode
            setEditing(false, animated: true)
        }
        else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: UIControlState())
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }

    
}
