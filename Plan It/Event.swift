//
//  Event.swift
//  Plan It
//
//  Created on 5/18/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

class Event: NSObject, NSCoding {
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(endDate, forKey: "endDate")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(alarm, forKey: "alarm")
        aCoder.encode(important, forKey: "important")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        date = aDecoder.decodeObject(forKey: "date") as! Date
        endDate = aDecoder.decodeObject(forKey: "endDate") as! Date
        location = aDecoder.decodeObject(forKey: "location") as! String
        alarm = aDecoder.decodeBool(forKey: "alarm")
        important = aDecoder.decodeBool(forKey: "important")

        super.init()
    }

    
}
