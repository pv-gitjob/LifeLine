//
//  AddMemberViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/30/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {

    var groupID = String()
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var roleField: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addMember(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let userinfo = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let admin = userinfo["phone"] as! String
        let phone = phoneField.text!
        let role = roleField.text!
        LifeLineAPICaller().addMember(groupID: groupID, admin: admin, member: phone, role: role, resultLabel: result)
        self.view.subviews.last?.removeFromSuperview()
    }

}
