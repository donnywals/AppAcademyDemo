//
//  AppDelegate.swift
//  iSpin
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.registerForRemoteNotifications()
        
        // register actions
        
        // register delegate
        
        return true
    }
    
    // https://www.raywenderlich.com/123862/push-notifications-tutorial
    // https://github.com/djacobs/PyAPNs
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for remote notifications")
        print(deviceToken.hexString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Could not register for remote notifications")
        print(error)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // receive game response
    
    // present in foreground
}
