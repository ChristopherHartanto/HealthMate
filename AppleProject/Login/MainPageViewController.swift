//
//  MainPageViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "email") != nil{
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    

}
