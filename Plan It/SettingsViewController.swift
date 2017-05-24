//
//  SettingsViewController.swift
//  Plan It
//
//  Created on 5/24/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var eventStore: EventStore!
    var dayStore: DayStore!
    var weeklyViewController: WeeklyViewController!
    
    @IBAction func clearEvents(sender: UIButton) {
        eventStore.clearEvents()
    }
    
    @IBAction func resetDate(sender: UIButton) {
        weeklyViewController.currentWeek = dayStore.getWeek(date: Date())
    }
    
    
}
