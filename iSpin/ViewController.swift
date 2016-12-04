//
//  ViewController.swift
//  iSpin
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet var enableNotificationsButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    self?.enableNotificationsAllowedUI()
                } else if settings.authorizationStatus == .denied {
                    self?.enableNotificationsDeniedUI()
                }
            }
        }
    }

    @IBAction func enableNotificationsTapped() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { [weak self] settings in
            if settings.authorizationStatus == .notDetermined {
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { success, error in
                    DispatchQueue.main.async {
                        if success {
                            self?.enableNotificationsAllowedUI()
                        } else {
                            self?.enableNotificationsDeniedUI()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func enableNotificationsAllowedUI() {
        enableNotificationsButton.isHidden = true
        
        titleLabel.text = "Notifications are enabled, you'll receive a daily push message."
    }
    
    func enableNotificationsDeniedUI() {
        titleLabel.text = "You have disabled notifications for iSpin, go to your settings to enable notifications."
    }
}

