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
        
        // read current settings
        
    }

    @IBAction func enableNotificationsTapped() {
        // request permissions
        
    }
    
    func enableNotificationsAllowedUI() {
        enableNotificationsButton.isHidden = true
        
        titleLabel.text = "Notifications are enabled, you'll receive a daily push message."
    }
    
    func enableNotificationsDeniedUI() {
        titleLabel.text = "You have disabled notifications for iSpin, go to your settings to enable notifications."
    }
}
