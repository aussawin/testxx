//
//  MainViewController.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/23/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var userTable: UITableView!
    var ref: DatabaseReference!
    var userList: Array<User> = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backMethod))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        userTable.dataSource = self
        userTable.delegate = self
        
        ref = Database.database().reference()
        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            let valueFir = snapshot.value as! NSDictionary
            let keyList = valueFir.allKeys as! [String]
            for i in keyList{
                let userInfo = valueFir.value(forKey: i) as! NSDictionary
                let username   = userInfo.value(forKey: "username")   as! String
                let password   = userInfo.value(forKey: "password")   as! String
                let latitude   = userInfo.value(forKey: "latitude")   as! Double
                let longtitude = userInfo.value(forKey: "longtitude") as! Double
                self.user = User(username: username, password: password, latitude: latitude, longtitude: longtitude)
                self.userList.append(self.user)
            }
            self.userTable.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].username
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.userTable.indexPathForSelectedRow{
            let destination = segue.destination as! MapViewController
            destination.user = userList[indexPath.row]
        }
    }
    
    @objc func backMethod(){
        let alert = UIAlertController(title: "Alert", message: "You want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:{ action in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
