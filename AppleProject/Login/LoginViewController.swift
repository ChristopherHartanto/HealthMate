//
//  LoginViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnLogin(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){ (user,error) in
            if error == nil{
                let userUID = Auth.auth().currentUser?.uid
                UserDefaults.standard.set(userUID, forKey: "userUID")
                self.performSegue(withIdentifier: "toGetStart", sender: self)
            }else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }
    }
    
}
