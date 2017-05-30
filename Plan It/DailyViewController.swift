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
    var eventStore: EventStore!
    
    override func viewWillAppear(_ animated: Bool) {
        if let day = currentDay {
            navigationItem.title = "\(day.dayOfWeek), \(day.month) \(String(day.dateNumber)), \(Calendar.current.component(.year, from: day.date))"
        } else {
            navigationItem.title = "\(today.dayOfWeek), \(today.month) \(String(today.dateNumber)), \(Calendar.current.component(.year, from: today.date))"
        }
        tableView.reloadData()
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100.0
    }
    
    let comparisonDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let timeOutputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    func getEventsForDay(_ day: Date)-> [Event] {
        var result = [Event]()
        for event in eventStore.allEvents {
            if comparisonDateFormatter.string(from: event.date) == comparisonDateFormatter.string(from: day) {
                result.append(event)
            }
        }
        return result.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }
    
    var events: [Event] {
        var item: Date
        if let day = currentDay {
            item = day.date
        } else {
            item = today.date
        }
        return getEventsForDay(item)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell",
                                                 for: indexPath as IndexPath) as! DailyCell
        
        cell.selectionStyle = .none
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview

        let event = events[indexPath.row]
        
        cell.eventNameLabel.text = event.name
        cell.eventLocationLabel.text = event.location
        cell.eventStartTimeLabel.text = timeOutputFormatter.string(from: event.date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    
}
