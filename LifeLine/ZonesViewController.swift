//
//  ZonesViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/23/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import MapKit
import UIKit


class ZonesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var table: UITableView!
	@IBOutlet var mapView: MKMapView!
	
    var groupID = String()
    var phone = String()
    var zones = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
		mapView.delegate = self
		self.mapView.isHidden = true
		self.table.rowHeight = 110.0

        let url = URL(string: LifeLineAPICaller().baseURL + "zone/zonegetallmember.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.zones = dataDictionary
                self.table.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = zones["size"] as? Int ?? 0
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = table.dequeueReusableCell(withIdentifier: "ZoneViewCell") as! ZoneViewCell
		
	
        let zone = zones[String(indexPath.row)] as! [String:Any]
		let name = zone["name"] as! String
        let latitude = zone["latitude"] as! Double
        let longitude = zone["longitude"] as! Double
        let start = zone["timing_start"] as! String
        let end = zone["timing_end"] as! String
        let radius = zone["radius"] as! Double
        let safe = zone["safe"] as! Bool
        
		cell.zoneName.text = name  
		
        
        return cell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let selectedZone = zones[String(indexPath.row)] as! [String:Any]
        let name = selectedZone["name"] as! String
		let latitude = selectedZone["latitude"] as! Double
		let longitude = selectedZone["longitude"] as! Double
		let start = selectedZone["timing_start"] as! String
		let end = selectedZone["timing_end"] as! String
		let radius = selectedZone["radius"] as! Double
		let safe = selectedZone["safe"] as! Bool
		
		
		let selectedZoneLocation = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: selectedZoneLocation.coordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        let subtitleString = "From \(start) to \(end)"
		let userLocationAnnotation = UsersLocationAnnotation(title: name, subtitle: subtitleString, coordinate: selectedZoneLocation.coordinate)
		
		let circle = MKCircle(center: selectedZoneLocation.coordinate, radius: 30.0)
        
       
		
		mapView.isHidden = false
        mapView.setRegion(region, animated: true)
		mapView.addAnnotation(userLocationAnnotation)
		mapView.addOverlay(circle)
      
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		   if annotation.isKind(of: MKUserLocation.self) {
			   return nil
		   }
		   if annotation.isKind(of: UsersLocationAnnotation.self) {
			   let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "zonePin")
			//annotationView
			   annotationView.pinTintColor = UIColor.green
			   annotationView.canShowCallout = true
			   let button = UIButton(type: .detailDisclosure)
			   annotationView.rightCalloutAccessoryView = button
			   return annotationView
		   }
		   return nil
	   }
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let renderer = MKCircleRenderer(overlay: overlay)
		renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
		renderer.strokeColor = UIColor.red
		renderer.lineWidth = 2
		return renderer
	}
	
	
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ZonesToZone" {
            let zone = zones[String(indexPath.row)] as! [String:Any]
            let groupDetailsViewController = segue.destination as! ChatViewController
            groupDetailsViewController.groupID = groupID
        }
    }
    */
}

