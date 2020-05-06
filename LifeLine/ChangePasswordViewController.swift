//
//  ChangePasswordViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/17/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var newPassword2Field: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        phone = (dict["phone"] as! String)
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let oldPassword = oldPasswordField.text!
        let newPassword = newPasswordField.text!
        let newPassword2 = newPassword2Field.text!
        oldPasswordField.text = ""
        newPasswordField.text = ""
        newPassword2Field.text = ""
        if (newPassword == newPassword2) {
            LifeLineAPICaller().changePassword(phone: phone, oldPassword: oldPassword, newPassword: newPassword, resultLabel: resultLabel)
        } else {
            resultLabel.text = "Passwords do not match"
        }
        self.view.subviews.last?.removeFromSuperview()
    }
    
}
