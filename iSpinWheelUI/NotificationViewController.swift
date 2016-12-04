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
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        // dismiss if cancelled
        let responseIdentifier = response.actionIdentifier
        
        if responseIdentifier == "cancel" {
            completion(.dismiss)
        }
        
        // spin if spin-wheel
        if responseIdentifier == "spin-wheel" {
            let animations: () -> Void = { [weak self] in
                self?.imageView.transform = CGAffineTransform(rotationAngle: 5)
            }
            
            let completion: (Bool) -> Void = { completed in
                completion(.dismissAndForwardAction)
            }
            
            UIView.animate(withDuration: 1, animations: animations, completion: completion)
        }
    }

}
