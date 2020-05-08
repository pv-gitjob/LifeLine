//
//  GroupMemberViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/23/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Alamofire

class GroupMemberViewController: UIViewController {

    var group = String()
    var member = [String:Any]()
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var roleField: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        name.text = member["name"] as? String
        roleField.text = member["role"] as? String
        phone.text = member["phone"] as? String

        let pictureUrl = URL(string: member["picture"] as! String)!
        Alamofire.request(pictureUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                    if let data = response.data {
                        self.picture.image = UIImage(data: data)
                        self.picture.setRounded()
                    }
            }
        }
        self.view.subviews.last?.removeFromSuperview()
    }

    @IBAction func setRole(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let user = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let adminStr = user["phone"] as! String
        let phoneStr = phone.text!
        let role = roleField.text!
        LifeLineAPICaller().changeRole(groupID: group, admin: adminStr, member: phoneStr, role: role, resultLabel: result)
        self.view.subviews.last?.removeFromSuperview()
    }
    
    @IBAction func removeUser(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let user = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let adminStr = user["phone"] as! String
        let phoneStr = phone.text!
        LifeLineAPICaller().deleteMember(groupID: group, admin: adminStr, member: phoneStr, resultLabel: result)
        self.view.subviews.last?.removeFromSuperview()
    }
    
}
