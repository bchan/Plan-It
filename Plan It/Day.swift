//
//  Day.swift
//  Plan It
//
//  Created on 3/15/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class Day : Equatable, CustomStringConvertible {
    
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
        case 1: return "Jan"
        case 2: return "Feb"
        case 3: return "Mar"
        case 4: return "Apr"
        case 5: return "May"
        case 6: return "Jun"
        case 7: return "Jul"
        case 8: return "Aug"
        case 9: return "Sep"
        case 10: return "Oct"
        case 11: return "Nov"
        case 12: return "Dec"
        default: return "someone is retarded!"
        }
    }
    
    var description: String {
        return "\(date)"
    }

    
}
