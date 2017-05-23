//
//  EventsViewController.swift
//  Plan It
//
//  Created on 5/18/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class EventsViewController : UITableViewController {
    
    var eventStore: EventStore!
    var editIndexPath: IndexPath?
    //    var tabBarVC: UITabBarController!
    
    override func viewDidLoad() {
//        print(#function)
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100.0
        
        eventStore = EventStore()
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        eventStore.moveEventAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                 for: indexPath as IndexPath) as! EventCell
        cell.selectionStyle = .none
        
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let event = eventStore.allEvents[indexPath.row]
        
        cell.nameLabel.text = event.name
        cell.dateLabel.text = String(describing: event.date)
        if event.important {
            cell.importantLabel.text = "!"
        } else {
            cell.importantLabel.text = ""
        }
        if event.alarm {
            cell.alarmLabel.text = "Alarm On"
        } else {
            cell.alarmLabel.text = "Alarm Off"
        }
        cell.locationLabel.text = event.location

        return cell
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        // Create a new Item and add it to the store
//        print(eventStore)
        let newItem = eventStore.createEvent()
        
        // Figure out where that item is in the array
        if let index = eventStore.allEvents.index(of: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            
            // Insert this new row into the table.
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = eventStore.allEvents[indexPath.row]
            
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                // Remove the item from the store
                                                self.eventStore.removeEvent(event: item)
                                                
                                                // Also remove that row from the table view with an animation
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventStore.allEvents.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        if segue.identifier == "showDetail" {
            let myCell = sender as! UITableViewCell
            //figure out which row was tapped
            if let indexPath = self.tableView.indexPath(for: myCell) {
                editIndexPath = indexPath
                //get item associated and pass it along
                let event = eventStore.allEvents[indexPath.row]
                let editViewController = segue.destination as! DetailViewController
                editViewController.event = event
            }
        }
    }

    
    
}
