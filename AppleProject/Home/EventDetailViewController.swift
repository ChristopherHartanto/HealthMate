//
//  EventDetailViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 31/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventDetailViewController: UIViewController {

    @IBOutlet weak var ivPeople: UIImageView!
    @IBOutlet weak var ivDate: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblEventHost: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    @IBAction func btnFavorite(_ sender: Any) {
        let alertController = UIAlertController(title: "Done", message: "Added to Favorite", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func btnShare(_ sender: Any) {
        let alertController = UIAlertController(title: "Done", message: "-", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ivDate.image = UIImage(named: "date")
        ivPeople.image = UIImage(named: "hostPeople")
        
        let ref = Database.database().reference()
        let itemRef = ref.child("Events")
        let eventName = UserDefaults.standard.string(forKey: "Name")
        let eventRef = itemRef.child(eventName!)
        
        eventRef.observe(.value, with: {(snapshot) in
            let value = snapshot.value as! [String : AnyObject]
            
            self.lblTitle.text = value["Name"] as? String
            self.lblDate.text = value["Date"] as? String
            self.lblGender.text = value["Gender"] as? String
            self.lblEventHost.text = value["HostEvent"] as? String
            self.lblDesc.text = value["Description"] as? String
        })
    }
    
    @IBAction func btnJoin(_ sender: Any) {
        let alertController = UIAlertController(title: "Done", message: "Join Success", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: self)
        UserDefaults.standard.removeObject(forKey: "Name")
    }

    
    
}
