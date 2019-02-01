//
//  RegisterViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 25/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "Cell"

class RegisterViewController : UIViewController{
    
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if password.text != passwordConfirm.text{
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please Re-Type Password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user,error) in
                if error == nil {
                    self.performSegue(withIdentifier: "toLogin", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        
        }
    }
}
