//
//  Speed.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/13/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import UIKit
import UIKit
import MapKit
import CoreMotion
import CoreLocation
import UserNotifications

class Speed: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let notificationController = UNMutableNotificationContent()
    let sendSpeedAlert = ChatViewController()
    func testSpeed() {
        print("started speed watch")

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        

    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let location = locations[0]
        var speed = location.speed
        print (speed)
        //self.speedDisplay.text! = String(location.speed)
        if speed > 10{
            notificationController.body = "slow down you are going  \(speed) at location \(location) "
         //   sendSpeedAlert.autoSpeedMessage(speed: "speed", location: location)
            
        }


    }



    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
