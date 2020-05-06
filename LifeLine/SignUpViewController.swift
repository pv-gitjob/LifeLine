//
//  SignUpViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/9/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if resultLabel.text == "success" {
            self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
            let phone = phoneField.text
            let user = PFUser()
            user.username = phone
            user.password = phone
            user.signUpInBackground { (success, error) in
                if success{
                    user.saveInBackground()
                    print("Created PFUser")
                }else{
                    if let descrip = error?.localizedDescription{
                        print(descrip)
                    }
                }
            }
            phoneField.text?.removeAll()
            nameField.text?.removeAll()
            passwordField.text?.removeAll()
            password2Field.text?.removeAll()
            resultLabel.text = ""
            self.view.subviews.last?.removeFromSuperview()
            self.performSegue(withIdentifier: "SignUpSegue", sender: self)
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let phone = phoneField.text!
        let name = nameField.text!
        let password = passwordField.text!
        let password2 = password2Field.text!
        if (password != password2) {
            resultLabel.text = "Passwords do not match"
            passwordField.text?.removeAll()
            password2Field.text?.removeAll()
            return
        }
        LifeLineAPICaller().signup(phone: phone, name: name, password: password, resultLabel: resultLabel)
        self.view.subviews.last?.removeFromSuperview()
    }

}
