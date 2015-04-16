//
//  AppDelegate.swift
//  Yogis
//
//  Created by Jeanie House on 3/24/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        //Parse.setApplicationId("FlGUsj6E5R62F3C93Wq9uYQxdrtzcUsEfjSYf8he",
            //clientKey:"ApYfwrGhERt8SugcsKiYy5XNTZaEJ3KBEBjLyLlG")
        
        
        // Register for Push Notitications
        
        let userNotificationType = (UIUserNotificationType.Alert |
            UIUserNotificationType.Badge |
            UIUserNotificationType.Sound)
        
        let settings = UIUserNotificationSettings(forTypes: userNotificationType, categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        

        
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.16, green: 0.48, blue: 0.86, alpha: 0.7)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = true
        

        
        let tabbar = UITabBar.appearance()
        tabbar.barTintColor = UIColor(red: 0.16, green: 0.48, blue: 0.86, alpha: 0.7)
        tabbar.tintColor = UIColor.whiteColor()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

