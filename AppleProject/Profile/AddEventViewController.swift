//
//  AddEventViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddEventViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var place: UITextField!

    @IBOutlet weak var sportCat: UITextField!
    @IBOutlet weak var desc: UITextField!
    
    var sportCatValue : String?
    var genderValue : String?
    var pickerSportItem : [String] = [String]()
    var pickerGenderItem : [String] = [String]()
    var hostEvent : String?
    let ref = Database.database().reference()
    
    var pickerSport:UIPickerView!
    var pickerGender : UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerSportItem = ["Cycling","Running","Basket","Badminton","Futsal"]
        pickerGenderItem = ["Male", "Female","Unisex"]
        
        pickerSport = UIPickerView()
        pickerSport.delegate = self
        pickerSport.dataSource = self
        
        pickerGender = UIPickerView()
        pickerGender.delegate = self
        pickerGender.dataSource = self
        
        sportCat.inputView = pickerSport
        gender.inputView = pickerGender
//        sportCat.inputAccessoryView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        sportCat.inputAccessoryView = toolBar
        gender.inputAccessoryView = toolBar
        
    }
    
    @objc func done(){
        sportCat.resignFirstResponder()
        gender.resignFirstResponder()
    }
    
    @objc func cancel(){
        if sportCat.isFirstResponder{
            sportCat.resignFirstResponder()
            sportCat.text = pickerSportItem[0]
        }else if gender.isFirstResponder{
            gender.resignFirstResponder()
            gender.text = pickerGenderItem[0]
        }
    }
    
    @IBAction func btnAddEvent(_ sender: Any) {
        if name.text == "" || date.text == "" || sportCat.text == "" || gender.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Fill All the Data!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            let itemRef = ref.child("Events")
            let eventItemRef = itemRef.child(name.text!)
            
            let userUID = UserDefaults.standard.string(forKey: "userUID")
            let userRef = ref.child("Users")
            let userItemRef = userRef.child(userUID ?? "")

            userItemRef.observe(.value, with: {(snapshot) in
                let value = snapshot.value as! [String : AnyObject]
                
                self.hostEvent = value["Name"] as? String
                print(userUID!)
                print(value["Name"] as? String as Any)
                
            })

            let event = Event(name: self.name.text!, date: self.date.text!, sportType: self.sportCatValue!, place: self.place.text!, gender: self.gender.text!, description: self.desc.text!, hostEvent : "chris")
            
            eventItemRef.setValue(event.toAnyObject())
           
            let alertController = UIAlertController(title: "Success", message: "Add Event Success", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
            name.text = ""
            date.text = ""
            sportCat.text = ""
            gender.text = ""
            place.text = ""
            desc.text = ""
        }
    }

}

extension AddEventViewController : UIPickerViewDelegate{
    
}

extension AddEventViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerSport{
            return pickerSportItem.count
        }
        else if pickerView == pickerGender{
            return pickerGenderItem.count
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerSport{
            return pickerSportItem[row]
        }else if pickerView == pickerGender{
            return pickerGenderItem[row]
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerSport{
            sportCatValue = pickerSportItem[pickerView.selectedRow(inComponent: 0)]
            sportCat.text = sportCatValue
        }else if pickerView == pickerGender{
            genderValue = pickerGenderItem[pickerView.selectedRow(inComponent: 0)]
            gender.text = genderValue
        }else{
            
        }
    }
}
