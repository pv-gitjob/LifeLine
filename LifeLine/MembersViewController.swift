//
//  MembersViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import CoreLocation
import MapKit
import Alamofire
import UIKit

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate  {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var result: UILabel!
    
    var group = [String:Any]()
    var dict = [String:Any]()
    var member = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        self.tableView.rowHeight = 110.0
        
        let url = URL(string: LifeLineAPICaller().baseURL + "group/groupmembergetmembers.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let groupID = group["group_id"] as! String
        let postString = "group_id=\(groupID)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.dict = dataDictionary
                self.tableView.reloadData()
            }
        }
        task.resume()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        let url = URL(string: LifeLineAPICaller().baseURL + "group/groupmembergetmembers.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let groupID = group["group_id"] as! String
        let postString = "group_id=\(groupID)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.dict = dataDictionary
                self.tableView.reloadData()
            }
        }
        task.resume()
        refreshControl.endRefreshing()
    }
    
    /*
     func getDate(date: String) -> Date? {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
     dateFormatter.timeZone = TimeZone.current
     dateFormatter.locale = Locale.current
     return dateFormatter.date(from: "2015-04-01T11:42:00") // replace Date String
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = dict["size"] as? Int ?? 0
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberViewCell") as! MemberViewCell
        let	groupMember = dict[String(indexPath.row)] as! [String:Any]
        let name = groupMember["name"] as! String
        let phone = groupMember["phone"] as! String
        let role = groupMember["role"] as! String
        //let when = groupMember["when"] as! String
        let pictureUrl = URL(string: groupMember["picture"] as! String)!
        Alamofire.request(pictureUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    cell.picture.image = UIImage(data: data)
                    cell.picture.setRounded()
                }
            }
        }
        cell.nameLabel.text = name
        cell.phoneLabel.text = phone
        cell.roleLabel.text = role
        cell.profileBtn.addTarget(self, action: #selector(memberButtonTapped(_:)), for: .touchUpInside)
        cell.zonesBtn.addTarget(self, action: #selector(zoneButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func memberButtonTapped(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            member = dict[String(indexPath.row)] as! [String:Any]
            result.text = "Member"
        }
        else {
            print("Button indexPath not found")
        }
    }
    
    @IBAction func zoneButtonTapped(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            member = dict[String(indexPath.row)] as! [String:Any]
            result.text = "Zone"
        }
        else {
            print("Button indexPath not found")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = dict[String(indexPath.row)] as! [String:Any]
        let name = selectedUser["name"] as! String
        let latitude = Double(selectedUser["latitude"] as! String)
        let longitude = Double(selectedUser["longitude"] as! String)
        let lastUpdated = selectedUser["when"] as! String
        /* Make the time user friendly from a String
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'0000"
         let date = dateFormatter.date(from: lastUpdated)
         print(date?.debugDescription)
         */
        let selectedUserLocation = CLLocation(latitude: latitude!, longitude: longitude!)
        let region = MKCoordinateRegion(center: selectedUserLocation.coordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        let subtitleString = "Last updated: \(lastUpdated)"
        let userLocationAnnotation = UsersLocationAnnotation(title: name, subtitle: subtitleString, coordinate: selectedUserLocation.coordinate)
        mapView.addAnnotation(userLocationAnnotation)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        if annotation.isKind(of: UsersLocationAnnotation.self) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "userPin")
            annotationView.pinTintColor = UIColor.green
            annotationView.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = button
            return annotationView
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembersToChat" {
            let chatViewController = segue.destination as! ChatViewController
            chatViewController.groupID = group["group_id"] as! String
        }
        
        if segue.identifier == "MembersToMember" {
            let memberViewController = segue.destination as! GroupMemberViewController
            memberViewController.group = group["group_id"] as! String
            memberViewController.member = member
        }
        
        if segue.identifier == "MembersToZones" {
            let memberViewController = segue.destination as! ZonesViewController
            memberViewController.groupID = group["group_id"] as! String
            memberViewController.phone = member["phone"] as! String
        }
        if segue.identifier == "MembersToSettings" {
            let GroupSettingsViewController = segue.destination as! GroupSettingsViewController
            GroupSettingsViewController.group = group
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if result.text == "Member" {
            result.text = ""
            self.performSegue(withIdentifier: "MembersToMember", sender: self)
        }
        if result.text == "Zone" {
            result.text = ""
            self.performSegue(withIdentifier: "MembersToZones", sender: self)
        }
    }
}
 
