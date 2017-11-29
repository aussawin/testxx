//
//  SignUpViewController.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/23/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class SignUpViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func randomLatLongMethods(_ sender: Any) {
        let location = randomDouble()
        latField.text = String(location[0])
        longField.text = String(location[1])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake{
            let location = randomDouble()
            latField.text = String(location[0])
            longField.text = String(location[1])
        }
    }
    
    func randomDouble() -> [Double]{
        let lat: Double = (Double(arc4random_uniform(170000000))/1000000)-85.000000
        let long: Double = (Double(arc4random_uniform(360000000))/1000000)-180.000000
        return [lat, long]
    }
    
    @IBAction func addDataMethods(_ sender: Any) {
        
        let isFieldEmpty = (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (latField.text?.isEmpty)! || (longField.text?.isEmpty)!
        
        if !isFieldEmpty {
            ref.child("user-post").observe(DataEventType.value, with: {(snapshot) in
                var isAvaliable = true
                if snapshot.exists() {
                    let valueFir = snapshot.value as! NSDictionary
                    let keyList = valueFir.allKeys as! [String]
                    for i in keyList{
                        let user = valueFir.value(forKey: i) as! NSDictionary
                        let username = user.value(forKey: "username") as! String
                        if username == self.usernameField.text!{
                            isAvaliable = false
                            self.showToast(message: "Username is unavaliable.")
                        }
                    }
                }
                if isAvaliable {
                    let key = self.ref.child("users").childByAutoId().key
                    let post = ["username": "\(self.usernameField.text!)",
                        "password": "\(self.passwordField.text!)",
                        "latitude": Double(self.latField.text!)!,
                        "longtitude": Double(self.longField.text!)!] as [String : Any]
                    let postName = ["username": "\(self.usernameField.text!)"]
                    let childUpdate = ["/users/\(key)": post,
                                       "/user-post/\(key)": postName]
                    self.ref.updateChildValues(childUpdate)
                    self.showToast(message: "Save data successfully")
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }else {
            showToast(message: "Some field is empty!")
        }
    }
}
