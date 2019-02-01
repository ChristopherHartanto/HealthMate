//
//  ProfileViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ivProfilePicture: UIImageView!
    var imageSport : [[UIImage]] = [[UIImage(named: "running1")!,UIImage(named: "running2")!,UIImage(named: "running3")!],[UIImage(named: "cycling1")!,UIImage(named: "cycling2")!,UIImage(named: "cycling3")!],[UIImage(named: "badminton1")!,UIImage(named: "badminton2")!,UIImage(named: "badminton3")!],[UIImage(named: "futsal1")!,UIImage(named: "futsal2")!,UIImage(named: "futsal3")!],[UIImage(named: "basket1")!,UIImage(named: "basket2")!,UIImage(named: "basket3")!]]
    
    enum TableSection : Int{
        case EventJoined = 0, EventHosted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
   //     ivProfilePicture.image =
        ivProfilePicture.image = UIImage(named: "basket1.jpg")
        let userUID = UserDefaults.standard.string(forKey: "userUID")
        let ref = Database.database().reference()
        let itemRef = ref.child("Users")

        let userItemRef = itemRef.child(userUID!)
        
        userItemRef.observe(.value, with: { (snapshot) in
            let value = snapshot.value as! [String : AnyObject]
            self.name.text = value["Name"] as? String
            self.city.text = value["City"] as? String
        })
    }
    
//    func choosePicker() {
//        let alertController = UIAlertController(title: "Select Option", message: nil, preferredStyle: (S_IREAD ? UIAlertControllerStyle.alert : UIAlertControllerStyle.actionSheet))
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action -> Void in
//        })
//        let gallery = UIAlertAction(title: "From Gallery", style: UIAlertAction.Style.default
//            , handler: { action -> Void in
//                self.openPicker(isCamera: false)
//        })
//        let camera = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default
//            , handler: { action -> Void in
//                self.openPicker(isCamera: true)
//        })
//        alertController.addAction(gallery)
//        alertController.addAction(camera)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func openPicker(isCamera : Bool) {
//        let picker:UIImagePickerController?=UIImagePickerController()
//        if isCamera {
//            picker!.sourceType = UIImagePickerController.SourceType.camera
//        } else {
//            picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
//            picker!.allowsEditing = true
//        }
//        picker?.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.present(picker!, animated: true, completion: nil)
//        }
//        else {
//            picker!.modalPresentationStyle = .popover
//            present(picker!, animated: true, completion: nil)//4
//            picker!.popoverPresentationController?.sourceView = ivProfilePicture
//            picker!.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
//        }
//    }
//
//    // MARK: - UIImagePickerControllerDelegate Methods
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            self.imgProfile.image = image
//        }
//        picker.dismiss(animated: true, completion: nil);
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
    
}

extension ProfileViewController : UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        
        cell.lblEventName.text = ""
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 25))
        //view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 25))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .EventJoined:
                label.text = "Event Joined"
            case .EventHosted:
                label.text = "Event Hosted"
            }
        }
        view.addSubview(label)
        return view
    }

}

extension ProfileViewController : UITableViewDelegate{
    
}
