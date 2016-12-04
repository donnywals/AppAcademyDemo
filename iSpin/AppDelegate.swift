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
        let notificationCenter = UNUserNotificationCenter.current()
        let spinAction = UNNotificationAction(identifier: "spin-wheel", title: "Spin the wheel", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "cancel", title: "Cancel", options: [.destructive])
        let category = UNNotificationCategory(identifier: "wheel", actions: [spinAction, cancelAction],
                                              intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories(Set([category]))
        
        // register delegate
        notificationCenter.delegate = self
        
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard response.actionIdentifier == "spin-wheel" else {
            completionHandler()
            return
        }
        
        let userDefaults = UserDefaults(suiteName: "group.donnywals.iSpin")
        guard let didWin = userDefaults?.object(forKey: "did-win-prize") as? Bool,
            let viewController = UIApplication.shared.keyWindow?.rootViewController as? ViewController else {
            completionHandler()
            return
        }
        
        if didWin {
            viewController.performSegue(withIdentifier: "ShowPrizeWon", sender: nil)
        } else {
            viewController.performSegue(withIdentifier: "ShowPrizeLost", sender: nil)
        }
        
        userDefaults?.removeObject(forKey: "did-win-prize")
        
        completionHandler()
    }
}
