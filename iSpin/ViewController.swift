//
//  ViewController.swift
//  iSpin
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var enableNotificationsButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if notifications are enabled and call the relevant method if needed
    }

    @IBAction func enableNotificationsTapped() {
        // check if notifications are denied and open settings if needed
    }
    
    func enableNotificationsAllowedUI() {
        enableNotificationsButton.isHidden = true
        
        titleLabel.text = "Notifications are enabled, you'll receive a daily push message."
    }
    
    func enableNotificationsDeniedUI() {
        titleLabel.text = "You have disabled notifications for iSpin, go to your settings to enable notifications."
    }
}

