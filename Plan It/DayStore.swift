//
//  DayStore.swift
//  Plan It
//
//  Created by Benjamin Chan on 3/15/17.
//  Copyright © 2017 Benjamin Chan. All rights reserved.
//

import Foundation
import UIKit

class DayStore {
    
    var allDays = [Day]()
    
    func getSundaysDate(date: Date) -> Date {
        return Calendar(identifier: .gregorian).date(from: Calendar(identifier: .gregorian).dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    }

    func getWeek(date: Date) -> [Day] {
        var week = [Day]()
        let sunday = Day(getSundaysDate(date: date))
        let index = allDays.index(of: sunday)
        week.append(sunday)
        for i in index!...index! + 6 {
            week.append(allDays[i])
            
        }
        return week
    }
    
    func addWeek(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = NSDateComponents()
        if !isDayInArray(date: date) {
            let sunday = getSundaysDate(date: date)
            allDays.append(Day(sunday))
            for i in 1...6 {
                components.day = i
                let newDay = calendar.date(byAdding: components as DateComponents, to: sunday)!
                allDays.append(Day(newDay))
            }
        }
    }
    
    func isDayInArray(date: Date) -> Bool {
        return allDays.contains(Day(date))
    }
    
    
    
    
}
