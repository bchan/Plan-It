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
    var currentWeek = [Day]()
    var tabBarVC: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
        
        dayStore.addWeek(date: Date())
        currentWeek = dayStore.getWeek(date: Date())
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
        let sunday = Day(dayStore.getSundaysDate(date: item.date))
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.day], from: item.date)
        components.day = 6
        let endDay = Day(calendar.date(byAdding: components , to: sunday.date)!)
        
        navigationItem.title = "Week of \(sunday.month) \(String(sunday.dateNumber)) - \(endDay.month) \(String(endDay.dateNumber))"
    
        cell.textLabel?.text = String(item.dateNumber)
        cell.detailTextLabel?.text = item.dayOfWeek
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDay" {
            let backItem = UIBarButtonItem()
            let dailyVC = segue.destination as! DailyViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            
            dailyVC.currentDay = dayStore.allDays[indexPath!.row]
            backItem.title = "Week"
            navigationItem.backBarButtonItem = backItem
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDay" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let calendar = Calendar(identifier: .gregorian)
            let now = Date()
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
            components.hour = 0
            components.minute = 0
            components.second = 0
            let today = Day(calendar.date(from: components)!)
            if today == dayStore.allDays[indexPath!.row] {
                
                
//                tabBarVC.tabBarController(tabBarController: tabBarVC, shouldSelectViewController: tabBarVC.childViewControllers[1])

                tabBarVC.selectedIndex = 1
                
                
                return false
            }
        }
        return true
    }
    
    
}

//extension UITabBarController {
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) {
//        
//        let fromView: UIView = tabBarController.selectedViewController!.view
//        let toView  : UIView = viewController.view
//        if fromView == toView {
//            return
//        }
//        
//        UIView.transition(from: fromView, to: toView, duration: 0.4, options: UIViewAnimationOptions.transitionCrossDissolve) { (finished:Bool) in
//            
//        }
//        
//        return
//    }
//}

    



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
