//
//  EventsViewController.swift
//  Plan It
//
//  Created on 5/18/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import UserNotificationsUI

class EventsViewController : UITableViewController, UNUserNotificationCenterDelegate {
    
    var eventStore: EventStore!
    var editIndexPath: IndexPath?
    
    func addAlarmImage(label: UILabel) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "quickaction_icon_alarm_2x.png")
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentString)
        label.attributedText = myString
    }
    
    func deleteAlarmImage(label: UILabel) {
        let myString = NSMutableAttributedString(string: "")
        label.attributedText = myString

    }
    
    func addStarImage(label: UILabel) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "quickaction_icon_favorite_2x.png")
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentString)
        label.attributedText = myString
    }
    
    func deleteStarImage(label: UILabel) {
        let myString = NSMutableAttributedString(string: "")
        label.attributedText = myString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerCategories()
        super.viewWillAppear(animated)
        eventStore.allEvents.sort(by: {$0.date.compare($1.date) == .orderedAscending})
        clearNotifications()
        addAllNotifications()
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
        
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let event = eventStore.allEvents[indexPath.row]
        
        cell.nameLabel.text = event.name
        cell.dateLabel.text = "\(dateFormatter.string(from: event.date)) to \(dateFormatter.string(from: event.endDate))"
        if event.important {
            addStarImage(label: cell.importantLabel)
            addNotification(date: event.endDate)
        } else {
            deleteStarImage(label: cell.importantLabel)
        }
        if event.alarm {
            addAlarmImage(label: cell.alarmImage)
        } else {
            deleteAlarmImage(label: cell.alarmImage)
        }
        cell.locationLabel.text = event.location

        return cell
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yyyy h:mm a"
        return formatter
    }()
    
    @IBAction func addNewItem(sender: AnyObject) {
        // Create a new Item and add it to the store
        // the old way
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
        
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            eventStore.allEvents.remove(at: indexPath.row)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    }
    
    func addNotification(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let center = UNUserNotificationCenter.current()
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Do you need more time?"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    func addAllNotifications() {
        let current = Date()
        for i in eventStore.allEvents {
            if i.endDate >= current {
                if i.alarm {
                    addNotification(date: i.endDate)
                }
            }
        }
    }
    
    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "more", title: "Need More Time", options: .foreground)
        let done = UNNotificationAction(identifier: "done", title: "Done", options: .destructive)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, done], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let calendar = Calendar(identifier: .gregorian)
        let userInfo = response.notification.request.content.userInfo
        let trigger = response.notification.request.trigger as! UNCalendarNotificationTrigger
        let dateComponents = trigger.dateComponents
        let date = calendar.date(from: dateComponents)
        
        //if let customData = userInfo["customData"] as? String {
          //  print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
                
            case "more":
                
                // the user tapped our "need more time" button
                
                let event = eventStore.getEvent(date!)
                eventStore.pushEvents(event)
                tableView.reloadData()
            case "done":
                let event = eventStore.getEvent(date!)
                event.alarm = false
                tableView.reloadData()
                
                break
                
            default:
                break
            }
       // }
        
        // you must call the completion handler when you're done
        completionHandler()
    }
    
    
    func getEvent(date: Date) {
        
    }
    
//
//        @IBAction func speedSlider(sender: UISlider) {
//            if colonyView.colony != nil {
//                timer.invalidate()
//                let currentSpeed = NSTimeInterval(sender.value)
//                if currentSpeed == 0 {
//                    timer.invalidate()
//                } else {
//                    timer = NSTimer.scheduledTimerWithTimeInterval(1 - currentSpeed, target: self, selector: "evolveColony", userInfo: nil, repeats: true)
//                }
//            }
//        }

        
        
            // old way
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let parentVC = self.parent
        let weeklyVC = parentVC?.parent?.childViewControllers[0].childViewControllers[0] as! WeeklyViewController
        weeklyVC.eventStore = eventStore
        let dailyVC = parentVC?.parent?.childViewControllers[1].childViewControllers[0] as! DailyViewController
        dailyVC.eventStore = eventStore
    }

    
    
}
