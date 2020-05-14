//
//  AccelerometerController.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/3/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import UIKit
import CoreMotion
import CoreLocation
import UserNotifications

class AccelerometerController: NSObject {

    var motionManager = CMMotionManager()

    private func startGyros() {
        let notificationController = UNMutableNotificationContent()
        notificationController.title = "Accident Alert"
        notificationController.subtitle = "Sudden Acceleration"
        notificationController.badge = 1
        notificationController.body = "Rapid change in motion"
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "largeAcc", content: notificationController, trigger: notificationTrigger)
        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0
            self.motionManager.startAccelerometerUpdates(to: OperationQueue.current! ){(data, error) in
            
                print(data as Any)
                if let myData = self.motionManager.accelerometerData{
                    if myData.acceleration.x >= 5 || myData.acceleration.y >= 5 ||
                        myData.acceleration.z >= 5{
                        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
                        LifeLineAPICaller().getAccidentAlert(phone: dict["phone"] as! String)
                        // Add chat
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    }
                }
            }
        }
    }
    
    func startAccelerometer() {
        if motionManager.isGyroAvailable {
            self.motionManager.gyroUpdateInterval = 1.0 / 60.0
            self.motionManager.startGyroUpdates()
            startGyros()
        }
    }

}
