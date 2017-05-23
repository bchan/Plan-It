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
        eventStore.allEvents.sort(by: {$0.date.compare($1.date) == .orderedAscending})
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
        cell.dateLabel.text = "\(dateFormatter.string(from: event.date)) to \(dateFormatter.string(from: event.endDate))"
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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        return formatter
    }()
    
    @IBAction func addNewItem(sender: AnyObject) {
        // Create a new Item and add it to the store
//        let newItem = eventStore.createEvent()
//        var saveIndex = NSIndexPath()
//        
//        // Figure out where that item is in the array
//        if let index = eventStore.allEvents.index(of: newItem) {
//            let indexPath = NSIndexPath(row: index, section: 0)
//            saveIndex = indexPath
//            print("!\(saveIndex)")
//            
//            // Insert this new row into the table.
//            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
//        }
        
       
        
        //let cell = tableView(tableView, cellForRowAt: saveIndex as IndexPath)
        
        performSegue(withIdentifier: "showDetail", sender: nil)
        
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
        if segue.identifier == "showDetail" {
            if sender != nil {
                let cell = sender as! UITableViewCell
                let indexPath = self.tableView.indexPath(for: cell)
                let event = eventStore.allEvents[indexPath!.row]
                let editViewController = segue.destination as! DetailViewController
                editViewController.event = event
            } else {
                let newItem = eventStore.createEvent()
                
                // Figure out where that item is in the array
                if let index = eventStore.allEvents.index(of: newItem) {
                    let indexPath = NSIndexPath(row: index, section: 0)
                    
                    // Insert this new row into the table.
                    tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                    let editViewController = segue.destination as! DetailViewController
                    editViewController.event = newItem
                }
            }
        }
        
            
//            if let myCell = sender {
//            let myCell = sender as! UITableViewCell
//            //figure out which row was tapped
//            
//            if let indexPath = self.tableView.indexPath(for: myCell) {
//                print("gets here")
//                editIndexPath = indexPath
//                //get item associated and pass it along
//                let event = eventStore.allEvents[indexPath.row]
//                let editViewController = segue.destination as! DetailViewController
//                editViewController.event = event
//            }
//        }
    }

    
    
}
