//
//  GetStartViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GetStartViewController: UIViewController {

    @IBOutlet weak var primarySport: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var city: UITextField!

    let userUID = UserDefaults.standard.string(forKey: "userUID")
    let ref = Database.database().reference()
    var sportCatValue : String?
    var genderValue : String?
    var sportCatItem : [String] = [String]()
    var genderItem : [String] = [String]()
    
    var pickerSportCat : UIPickerView!
    var pickerGender : UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportCatItem = ["Cycling","Running","Basket","Badminton","Futsal","Volley","Swimming"]
        genderItem = ["Male","Female"]
        
        let itemRef = ref.child("Users")
        
        itemRef.observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.userUID!){
                self.performSegue(withIdentifier: "toHome", sender: self)
            }
        })
        
        pickerSportCat = UIPickerView()
        pickerGender = UIPickerView()
        
        pickerGender.delegate = self
        pickerGender.dataSource = self
        
        pickerSportCat.delegate = self
        pickerSportCat.dataSource = self

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
        
        primarySport.inputAccessoryView = toolBar
        gender.inputAccessoryView = toolBar
        
    }
    
    @objc func done(){
        primarySport.resignFirstResponder()
        gender.resignFirstResponder()
    }
    
    @objc func cancel(){
        if primarySport.isFirstResponder{
            primarySport.resignFirstResponder()
            primarySport.text = sportCatItem[0]
        }else if gender.isFirstResponder{
            gender.resignFirstResponder()
            gender.text = genderItem[0]
        }
    }

    @IBAction func btnNext(_ sender: Any) {
        if gender.text == nil || name.text == nil || city == nil{
            
        }else{
            let itemRef = ref.child("Users")
            let userItemRef = itemRef.child(self.userUID!)
            
            let user = User(name: name.text ?? "", primarySport: sportCatValue ?? "", city: city.text ?? "", gender: gender.text ?? "")
            
            userItemRef.setValue(user.toAnyObject())
            
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
}

extension GetStartViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerSportCat{
            return sportCatItem.count
        }else if pickerView == pickerGender{
            return genderItem.count
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerSportCat{
            sportCatValue = sportCatItem[pickerView.selectedRow(inComponent: 0)]
            primarySport.text = sportCatValue
        }else if pickerView == pickerGender{
            genderValue = genderItem[pickerView.selectedRow(inComponent: 0)]
            gender.text = genderValue
        }else{
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerSportCat{
            return sportCatItem[row]
        }else if pickerView == pickerGender{
            return genderItem[row]
        }else{
            return ""
        }
    }
}

extension GetStartViewController : UIPickerViewDelegate{
    
}
