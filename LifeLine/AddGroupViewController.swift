//
//  AddGroupViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse

class AddGroupViewController: UIViewController {
    
    @IBOutlet weak var GroupNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CreateGroupButton(_ sender: Any) {
        let name = GroupNameField.text!
        let userinfo = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let phone = userinfo["phone"]
        
        if (name != "") {
            self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
            LifeLineAPICaller().createGroup(groupName: name, phone: phone as! String)
            self.view.subviews.last?.removeFromSuperview()
        }
    }
    
}
