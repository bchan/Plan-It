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

class WeeklyViewController: UITableViewController, UIGestureRecognizerDelegate {
        
    var dayStore: DayStore!
    var currentWeek = [Day]()
    var tabBarVC: UITabBarController!
    
    @IBAction func shiftLeft(_ sender: UIBarButtonItem) {
        let sunday = currentWeek[0]
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.day], from: sunday.date)
        components.day = -7
        let newDay = Day(calendar.date(byAdding: components, to: sunday.date)!)
        if dayStore.isDayInArray(date: newDay.date) {
            currentWeek = dayStore.getWeek(date: newDay.date)
            self.tableView.reloadData()
        } else {
            dayStore.addWeek(date: newDay.date)
            currentWeek = dayStore.getWeek(date: newDay.date)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func shiftRight(_ sender: UIBarButtonItem) {
        let sunday = currentWeek[0]
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.day], from: sunday.date)
        components.day = 7
        let newDay = Day(calendar.date(byAdding: components, to: sunday.date)!)
        if dayStore.isDayInArray(date: newDay.date) {
            currentWeek = dayStore.getWeek(date: newDay.date)
            print("deez")
            self.tableView.reloadData()
        } else {
            dayStore.addWeek(date: newDay.date)
            currentWeek = dayStore.getWeek(date: newDay.date)
            self.tableView.reloadData()
            print(currentWeek)
            print("nuts")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayStore.addWeek(date: Date())
        currentWeek = dayStore.getWeek(date: Date())
        
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeRight)
//        
//        var swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeLeft)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeek.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
//        let item = dayStore.allDays[indexPath.row]
//        let sunday = Day(dayStore.getSundaysDate(date: item.date))
        let item = currentWeek[indexPath.row]
        let sunday = currentWeek[0]
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.day], from: sunday.date)
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
            
            dailyVC.currentDay = currentWeek[indexPath!.row]
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
            if today == currentWeek[indexPath!.row] {
                
                
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
