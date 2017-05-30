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
    
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges() -> Bool {
        print("Saving events to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allEvents, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Event] {
            allEvents += archivedItems
        }
        
    }
    
    func clearEvents() {
        allEvents = []
    }
    
    var dtf: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func pushEvents(_ event: Event) {
        let save = event.date
        event.date.addTimeInterval(600)
        for e in allEvents {
            if dtf.string(from: save) == dtf.string(from: e.date) {
                e.date.addTimeInterval(600)
            }
        }
        

    }
}
