//
//  EditViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 29/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var primarySport: UITextField!
    let ref = Database.database().reference()
    let userUID = UserDefaults.standard.string(forKey: "userUID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRef = ref.child("Users")
        let userItemRef = itemRef.child(userUID!)
        
        userItemRef.observe(.value) { (snapshot) in
            let value = snapshot.value as! [String : AnyObject]
            
            self.name.text = value["Name"] as? String
            self.gender.text = value["Gender"] as? String
            self.city.text = value["City"] as? String
            self.primarySport.text = value["PrimarySport"] as? String

        }
    }

    @IBAction func btnSave(_ sender: Any) {
        let userItem = User(name: self.name.text!, primarySport: self.primarySport.text!, city: self.city.text!, gender: self.gender.text!)
        
        let itemRef = ref.child("Users").child(userUID!)
        
        itemRef.updateChildValues(
            userItem.toAnyObject() as! [AnyHashable : Any]
            
        )
        
        let alertController = UIAlertController(title: "Done", message: "Edit Success", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "toHome", sender: self)
    }


}
