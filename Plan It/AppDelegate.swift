//
//  AppDelegate.swift
//  Plan It
//
//  Created on 3/08/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var eventStore = EventStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let dayStore = DayStore()
        let tabBarViewController = window!.rootViewController
        let navController = tabBarViewController?.childViewControllers[0]
        
        let weeklyController = navController?.childViewControllers[0] as! WeeklyViewController
        weeklyController.dayStore = dayStore
        weeklyController.tabBarVC = tabBarViewController as! UITabBarController
        
        let navController2 = tabBarViewController?.childViewControllers[2]
        let eventViewController = navController2?.childViewControllers[0] as! EventsViewController
//        let eventStore = EventStore()
        eventViewController.eventStore = eventStore
        weeklyController.eventStore = eventStore
        
        let navController3 = tabBarViewController?.childViewControllers[3]
        let settingsViewController = navController3?.childViewControllers[0] as! SettingsViewController
        settingsViewController.eventStore = eventStore
        settingsViewController.dayStore = dayStore
        settingsViewController.weeklyViewController = weeklyController
        
        let navController1 = tabBarViewController?.childViewControllers[1]
        let dailyController = navController1?.childViewControllers[0] as! DailyViewController
        dailyController.eventStore = eventStore
        
//        tabBarViewController?.navigationController?.navigationBar.barTintColor = UIColor.cyan
        // ^^doesn't do anything...
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//        UINavigationBar.appearance().tintColor = UIColor.clearColor
//        
//        UINavigationBar.appearance().barTintColor = UIColor.cyan
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let tabBarViewController = window!.rootViewController
        let navController = tabBarViewController?.childViewControllers[2]
        let eventsController = navController?.childViewControllers[0] as! EventsViewController
        let success = eventsController.eventStore.saveChanges()
        if success {
//            print("Saved all of the Items")
        } else {
//            print("Could not save any of the Items")
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

func ==(left: Day, right: Day) -> Bool {
    if left.date == right.date && left.date == right.date {
        return true
    } else {
        return false
    }
}

func ==(left: Event, right: Event) -> Bool {
    if left.date == right.date && left.date == right.date {
        return true
    } else {
        return false
    }
}



