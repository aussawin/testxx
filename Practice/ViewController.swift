//
//  ViewController.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/23/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController{
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginMethod(_ sender: Any) {
        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            let valueFir = snapshot.value as! NSDictionary
            let keyList = valueFir.allKeys as! [String]
            for i in keyList{
                let user = valueFir.value(forKey: i) as! NSDictionary
                let thisUsername = user.value(forKey: "username") as! String
                let thisPassword = user.value(forKey: "password") as! String
                let isUser = thisUsername == self.usernameTextField.text && thisPassword == self.passwordTextField.text
                if isUser {
                    self.showToast(message: "Login success")
                    sleep(1)
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
            self.showToast(message: "Login fail")
        })
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
}

extension UIViewController {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-75, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

