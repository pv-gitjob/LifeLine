//
//  LifeLineAPICaller.swift
//  LifeLine
//
//  Created by Praveen V on 3/8/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LifeLineAPICaller {
    
    let baseURL = "http://praveenv.org/lifeline/"
    
    func signin(phone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personlogin.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            dataDictionary["password"] = password
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func signup(phone:String, name:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(name)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            var dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            dataDictionary["password"] = password
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func changePicture(phone:String, image: Data?, resultLabel:UILabel) {
        let url = baseURL + "person/personpictureupload.php"

        let parameters = ["phone": phone]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
                multipartFormData.append(image!, withName: "fileToUpload", fileName: "poop.png", mimeType: "image/png")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if var dataDictionary = response.result.value as? [String: Any] {
                            let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
                            let password = dict["password"] as! String
                            dataDictionary["password"] = password
                            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    func changeName(phone:String, name:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetname.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
            let password = dict["password"] as! String
            dataDictionary["password"] = password
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func deletePicture(phone:String, resultLabel:UILabel) {
        let url = baseURL + "person/personpicturedelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
            let password = dict["password"] as! String
            dataDictionary["password"] = password
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func changePhone(oldPhone:String, newPhone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetphone.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "old_phone=\(oldPhone)&new_phone=\(newPhone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
            let password = dict["password"] as! String
            dataDictionary["password"] = password
            self.setUserInfo(number: newPhone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func setUserInfo(number:String, dict:[String : Any], label:UILabel) {
        DispatchQueue.main.async {
            let result = dict["result"] as? String
            label.text = result
            if (result == "success") {
                let name = dict["name"] as! String
                let picture = dict["picture"] as! String
                let password = dict["password"] as! String
                
                let dict:[String:String] = ["loggedin":"yes", "phone":number, "name":name, "picture":picture, "password":password]
                if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
                    print("Unable to save userinfo")
                }
            }
        }
    }
    
    func changePassword(phone:String, oldPassword:String, newPassword:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetpassword.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&old_pass=\(oldPassword)&new_pass=\(newPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as? String
            
            if result == "success" {
                var dict = Archiver().getObject(fileName: "userinfo") as! [String: Any]
                dict["password"] = newPassword
            }
            
            DispatchQueue.main.async {
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func deleteAccount(phone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/persondelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
                if (result == "success") {
                    
                    let dict:[String:String] = ["loggedin":"no"]
                    if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
                        print("Unable to save userinfo")
                    }
                }
            }
        }
        task.resume()
    }
    
    func updateLocation(phone:String, latitude:Double, longitude:Double, when:String) {
        let url = baseURL + "person/personsetlocation.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&latitude=\(latitude)&longitude=\(longitude)&when=\(when)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            if result != "success" {
                print(result)
            }
        }
        task.resume()
    }
    
    func forgetPassword(phone:String, resultLabel:UILabel) {
        let url = baseURL + "person/personforgotpassword.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }

    func getAccidentAlert(phone:String) {
        let url = baseURL + "group/groupaccidentalert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            print(result)
        }
        task.resume()
    }
    
    func createGroup(groupName:String, phone:String){
        let url = baseURL + "group/groupinsert.php"

        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(groupName)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            if result != "success" {
                print(result)
            }
        }
        task.resume()
    }
    
    func changeRole(groupID:String, admin:String, member:String, role:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupmembersetrole.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&admin_phone=\(admin)&phone=\(member)&role=\(role)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func deleteMember(groupID:String, admin:String, member:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupmemberdelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&admin_phone=\(admin)&phone=\(member)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func changeGroupOwner(groupID:String, owner:String, newOwner:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupchangeowner.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&old_owner=\(owner)&new_owner=\(newOwner)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func changeGroupName(groupID:String, owner:String, name:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupsetname.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&owner_phone=\(owner)&name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func addMember(groupID:String, admin:String, member:String, role:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupmemberinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&admin_phone=\(admin)&phone=\(member)&role=\(role)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            resultLabel.text = result
        }
        task.resume()
    }
    
    func addZone(groupID:String, admin:String, member:String, latitude:String, longitude:String, start:String, end:String, radius:Double, safe:Int, resultLabel:UILabel) {
        let url = baseURL + "zone/zoneinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&admin_phone=\(admin)&phone=\(member)&latitude=\(latitude)&longitude=\(longitude)&timing_start=\(start)&timing_end=\(end)&radius=\(radius)&safe=\(safe)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            resultLabel.text = result
        }
        task.resume()
    }
        
    func deleteZone(groupID:String, admin:String, member:String, latitude:String, longitude:String, resultLabel:UILabel) {
        let url = baseURL + "zone/zonedelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&admin_phone=\(admin)&phone=\(member)&latitude=\(latitude)&longitude=\(longitude)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            resultLabel.text = result
        }
        task.resume()
    }
    
    func leaveGroup(phone:String, groupId:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupmemberleave.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupId)&phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            
            DispatchQueue.main.async {
                resultLabel.text = result
            }
        }
        task.resume()
    }

    func deleteGroup(phone:String, groupId:String, resultLabel:UILabel) {
        let url = baseURL + "group/groupdelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "owner_phone=\(phone)&group_id=\(groupId)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as? String

            DispatchQueue.main.async {
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func changeGroupPicture(groupID:String, image: Data?, resultLabel:UILabel) {
        let url = baseURL + "group/grouppictureupload.php"

        let parameters = ["group_id": groupID]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
                multipartFormData.append(image!, withName: "fileToUpload", fileName: "poop.png", mimeType: "image/png")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if var dataDictionary = response.result.value as? [String: Any] {
                            let result = dataDictionary["result"] as! String
                            resultLabel.text = result
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
}
