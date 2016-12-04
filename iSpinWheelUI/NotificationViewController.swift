//
//  NotificationViewController.swift
//  iSpinWheelUI
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let wheelImageString = notification.request.content.userInfo["wheel-image"] as? String,
            let wheelImageUrl = URL(string: wheelImageString)
            else { return }
        
        // store image, add media
        URLSession.shared.dataTask(with: wheelImageUrl) { [weak self] data, response, error in
            
            guard let data = data
                else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }

}
