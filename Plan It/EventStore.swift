//
//  EventStore.swift
//  Plan It
//
//  Created on 5/19/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

class EventStore {
    
    var allEvents: [Event] = []
    
    func moveEventAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = allEvents[fromIndex]
        
        // Remove item from array
        allEvents.remove(at: fromIndex)
        
        // Insert item in array at new location
        allEvents.insert(movedItem, at: toIndex)
    }
    
    @discardableResult func createEvent()-> Event {
        let newEvent = Event(name: "", date: Date(), location: "", important: false, alarm: false, endDate: Date())
        
        allEvents.append(newEvent)
        
        return newEvent
    }
    
    func removeEvent(event: Event) {
        if let index = allEvents.index(of: event) {
            allEvents.remove(at: index)
        }
    }
    
}
