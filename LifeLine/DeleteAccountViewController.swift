//
//  DeleteAccountViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/20/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var acknowledgeSwitch: UISwitch!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let acknowledge = acknowledgeSwitch.isOn
        let phone = phoneLabel.text!
        let password = passwordField.text!
        passwordField.text?.removeAll()
        if (acknowledge) {
            LifeLineAPICaller().deleteAccount(phone: phone, password: password, resultLabel: resultLabel)
        } else {
            resultLabel.text = "Click the acknowledge switch"
        }
        self.view.subviews.last?.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if resultLabel.text == "success" {
            phoneLabel.text = ""
            resultLabel.text = ""
            acknowledgeSwitch.setOn(false, animated: true)
            self.performSegue(withIdentifier: "DeleteAccountSegue", sender: self)
        }
    }
    
}
