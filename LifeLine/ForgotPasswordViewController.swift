//
//  ForgotPasswordViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/22/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }        
    
    @IBAction func resetPassword(_ sender: Any) {
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        let phone = phoneField.text!
        LifeLineAPICaller().forgetPassword(phone: phone, resultLabel: resultLabel)
        self.view.subviews.last?.removeFromSuperview()
    }
    
}
