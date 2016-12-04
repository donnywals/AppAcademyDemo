//
//  NotificationService.swift
//  iSpinWheelExtension
//
//  Created by Donny Wals on 04/12/2016.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // modify title and extract image url
            bestAttemptContent.title = "You can win an awesome prize!"
            bestAttemptContent.body = "Spin the wheel to find out if you've won!"
            
            guard let wheelImageString = request.content.userInfo["wheel-image"] as? String,
                let wheelImageUrl = URL(string: wheelImageString) else {
                    contentHandler(bestAttemptContent)
                    return
            }
            // store image, add media
            URLSession.shared.dataTask(with: wheelImageUrl) { data, response, error in
                
                guard let data = data,
                    let imageDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                    contentHandler(bestAttemptContent)
                    return
                }
                
                let imageURL = URL(fileURLWithPath: imageDirectory.appending("/wheel-image.png"))
                
                do {
                    try data.write(to: imageURL)
                    let attachment = try UNNotificationAttachment(identifier: "wheel-image", url: imageURL, options: nil)
                    bestAttemptContent.attachments = [attachment]
                } catch let writeError {
                    print(writeError)
                }
                
                contentHandler(bestAttemptContent)
            }.resume()
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
