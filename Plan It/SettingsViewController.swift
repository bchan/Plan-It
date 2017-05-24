//
//  SettingsViewController.swift
//  Plan It
//
//  Created by Benjamin Chan on 5/24/17.
//  Copyright © 2017 Benjamin Chan. All rights reserved.
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
