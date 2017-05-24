//
//  DayStore.swift
//  Plan It
//
//  Created on 3/15/2017.
//  Copyright © 2017. All rights reserved.
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
        for i in index!...index! + 6 {
            week.append(allDays[i])
            
        }
        print(week)
        return week
    }
    
    func addWeek(date: Date) {
        print(#function)
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
        print(allDays)
        allDays.sort(by: {$0.date.compare($1.date) == .orderedAscending})
    }
    
    func isDayInArray(date: Date) -> Bool {
        let sunday = getSundaysDate(date: date)
        return allDays.contains(Day(sunday))
    }
    
    
//    let date1 = Date()
//    
//    init() {
//        addWeek(date: date1)
//    }
    
}
