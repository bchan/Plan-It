//
//  Day.swift
//  Plan It
//
//  Created on 3/15/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class Day: Equatable, CustomStringConvertible {
    
    let date: Date
    
    init(_ date: Date) {
        self.date = date
    }
    
    var dayOfWeekInt: Int {
        return Calendar.current.component(.weekday, from: date)
    }
    
    var dayOfWeek: String {
        switch dayOfWeekInt {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return "someone is retarded!"
        }
    }
    
    var dateNumber: Int {
        return Calendar.current.component(.day, from: date)
    }
    
    var monthNumber: Int {
        return Calendar.current.component(.month, from: date)
    }
    
    var month: String {
        switch monthNumber {
        case 1: return "January"
        case 2: return "February"
        case 3: return "March"
        case 4: return "April"
        case 5: return "May"
        case 6: return "June"
        case 7: return "July"
        case 8: return "August"
        case 9: return "September"
        case 10: return "October"
        case 11: return "November"
        case 12: return "December"
        default: return "someone is retarded!"
        }
    }
    
    var description: String {
        return "\(date)"
    }

    
}
