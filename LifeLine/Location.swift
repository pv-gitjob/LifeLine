//
//  Location.swift
//  LifeLine
//
//  Created by Stephen Baity on 4/30/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import CoreLocation
import Foundation
import UIKit

class Location: CLLocationManager, CLLocationManagerDelegate {
	static let manager = Location()
	
	var dict = NSDictionary()
	var phone = String()
	

	func checkLocationServices() {
		
		if CLLocationManager.locationServicesEnabled() {
			
			Location.manager.desiredAccuracy = kCLLocationAccuracyBest
			   }
		checkLocationAuthorization()
		
		print("Checking location services")
	}
	
	func checkLocationAuthorization() {
		print("Checking location authorization")
		   switch CLLocationManager.authorizationStatus() {
		   case .authorizedWhenInUse:
			Location.manager.startUpdatingLocation()
			
			
			   break
		   case .denied:
			   let cancelAction = UIAlertAction(title: "Ok",
									style: .cancel) { (action) in
			   }

			   let defaultAction = UIAlertAction(title: "Settings",
									style: .default) { (action) in
			   UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
			   }


			   let alert = UIAlertController(title: "Location Services Off",
					 message: "Turn on Location Services in Settings > Privacy to allow [App Name] to determine your current location",
					 preferredStyle: .alert)

			   alert.addAction(defaultAction)
			   alert.addAction(cancelAction)

			alert.present(alert, animated: true) {
				  // The alert was presented
			   }
			   break
		   case .notDetermined:
			   Location.manager.requestWhenInUseAuthorization()
		   case .restricted:
			   //Show an alert letting them know whats up
			   break
		   case .authorizedAlways:
			   Location.manager.startUpdatingLocation()

			   break
		   }
	   }
	
	func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String ) {
        // Make sure the devices supports region monitoring.
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
			let maxDistance = 10.0
            let region = CLCircularRegion(center: Location.manager.location!.coordinate,
                 radius: maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true

            Location.manager.startMonitoring(for: region)

        }
    }
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation = locations.last!
		let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
       
		
		LifeLineAPICaller().updateLocation(phone: phone, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, when: "\(userLocation.timestamp)")
		
		print(userLocation)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }


    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let region = region as? CLCircularRegion {
            let identifier = region.identifier
            let defaultAction = UIAlertAction(title: "Ok",
                                 style: .cancel) { (action) in
            }


            let alert = UIAlertController(title: "Congrats",
                  message: "Region monitoring was a success, as you have left the \(identifier) region",
                  preferredStyle: .alert)

            alert.addAction(defaultAction)

            alert.present(alert, animated: true) {
               // The alert was presented
            }
        }
	}
	
	

    

}
