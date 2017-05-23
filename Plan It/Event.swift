//
//  Event.swift
//  Plan It
//
//  Created on 5/18/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

class Event: NSObject {
    
    var name: String
    var date: Date
    var location: String
    var important: Bool
    var alarm: Bool
    var endDate: Date
    
    init(name: String, date: Date, location: String, important: Bool, alarm: Bool, endDate: Date) {
        self.name = name
        self.date = date
        self.location = location
        self.important = important
        self.alarm = alarm
        self.endDate = endDate
    }
    
    override var description: String {
        return "name: \(name); date: \(date); location: \(location); important: \(important); alarm: \(alarm)"
    }

}
