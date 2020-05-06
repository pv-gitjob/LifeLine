//
//  ChatViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let userDict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
    var messages: [PFObject] = []
    var userName = String()
    var groupID = String()
    var groupNum  = String()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        groupNum =  "group" + groupID
        self.userName = (userDict["name"] as! String) + " @ " + (userDict["phone"] as! String)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        tableView.reloadData()
    }

    @objc func retrieveChatMessages() {
        let query = PFQuery(className: groupNum)
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }

    @IBAction func onSend(_ sender: Any) {
        if messageTextField.text!.isEmpty == false {
            print(groupNum)
            let chatMessage = PFObject(className: groupNum)
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
            chatMessage["nameField"] = self.userName
            chatMessage["picture"] = userDict["picture"]
            
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    self.messageTextField.text = ""
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        } else {
            print("\nMessage cannot be empty\n")
        }
        tableView.reloadData()
    }
    
    func autoAccident(location: CLLocation, groupID: String){
        let groupNum = "group" + groupID
        let chatMessage = PFObject(className: groupNum)
        chatMessage["text"] = " I may have been in an accident at \(location)"
        chatMessage["nameField"] = self.userName
        chatMessage["picture"] = userDict["picture"]
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground()
    }

    func autoSpeedMessage(speed: String, location: CLLocation, groupID: String){
        let groupNum = "group" + groupID
        let chatMessage = PFObject(className: groupNum)
        chatMessage["text"] = "Speeding at \(speed) mph"
        chatMessage["nameField"] = self.userName
        chatMessage["picture"] = userDict["picture"]
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground()
    }

    func autoGeoFenceMessage(location: CLLocation, groupID: String){
        let groupNum = "group" + groupID
        let chatMessage = PFObject(className: groupNum)
        chatMessage["text"] = " left the geofence and is at: \(location) "
        chatMessage["user"] = PFUser.current()
        chatMessage["nameField"] = self.userName
        chatMessage["picture"] = userDict["picture"]
        chatMessage.saveInBackground()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    struct Cells {
        static let chatCell = "ChatCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chatCell, for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        cell.usernameLabel.text = message["nameField"] as? String
        
        let picStr = message["picture"] as? String
        if picStr != nil {
            let pictureUrl = URL(string: picStr!)!
            Alamofire.request(pictureUrl).responseData { (response) in
                if response.error == nil {
                        if let data = response.data {
                            cell.picture.image = UIImage(data: data)
                            cell.picture.setRounded()
                        }
                    }
                }
        }

        return cell
    }

}
