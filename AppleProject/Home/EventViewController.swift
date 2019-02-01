//
//  EventViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Category{
    var name:String
    var events:[String]
}

enum TableSection : Int{
    case Running = 0, Cycling, Badminton, Futsal, Basket
}

protocol EventDelegate {
    func selectedEvent(name:String)
}
class EventViewController: UIViewController {
    
    var arr:[Category] = []
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    let ref = Database.database().reference()
    
    var items : [String] = []
    var imageSport : [[UIImage]] = [[UIImage(named: "running1")!,UIImage(named: "running2")!,UIImage(named: "running3")!],[UIImage(named: "cycling1")!,UIImage(named: "cycling2")!,UIImage(named: "cycling3")!],[UIImage(named: "badminton1")!,UIImage(named: "badminton2")!,UIImage(named: "badminton3")!],[UIImage(named: "futsal1")!,UIImage(named: "futsal2")!,UIImage(named: "futsal3")!],[UIImage(named: "basket1")!,UIImage(named: "basket2")!,UIImage(named: "basket3")!]]
    
    
    
    var data = [TableSection: [String]]()
    let SectionHeaderHeight: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.reloadData()
    }
    
    func loadData(type:String){
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: type)
        itemRef.observe(.value, with: { snapshot in
            
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.arr.append(Category.init(name: type, events: item))
        })
    }
    
    func loadAllData(){
        loadDataRunning()
        loadDataBasket()
        loadDataFutsal()
        loadDataBadminton()
        loadDataCycling()
    }
    
    func loadDataRunning() {
        
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: "Running")
        itemRef.observe(.value, with: { snapshot in
        
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.data[.Running] = item
            self.items.append(contentsOf: item)
        })
        
    }
    
    func loadDataCycling() {
        
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: "Cycling")
        itemRef.observe(.value, with: { snapshot in
            
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.data[.Cycling] = item
            self.items.append(contentsOf: item)
        })
        
    }
    
    func loadDataBasket() {
        
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: "Basket")
        itemRef.observe(.value, with: { snapshot in
            
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.data[.Basket] = item
            self.items.append(contentsOf: item)
        })
        
    }
    
    func loadDataFutsal() {
        
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: "Futsal")
        itemRef.observe(.value, with: { snapshot in
            
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.data[.Futsal] = item
            self.items.append(contentsOf: item)
        })
        
    }
    
    func loadDataBadminton() {
        
        let itemRef = ref.child("Events").queryOrdered(byChild: "SportType").queryEqual(toValue: "Badminton")
        itemRef.observe(.value, with: { snapshot in
            
            var item : [String] = []
            
            for child in snapshot.children{
                let snapshot = child as! DataSnapshot
                let value = snapshot.value as! [String : AnyObject]
                item.append(value["Name"] as! String)
            }
            self.data[.Badminton] = item
            self.items.append(contentsOf: item)
        })
        
    }

    

}
extension EventViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let tableSection = TableSection(rawValue: section), let eventData = data[tableSection] {
//            return eventData.count
//        }
//        return self.data[TableSection.init(rawValue: section)!]?.count ?? 0
        return 1
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        // If we wanted to always show a section header regardless of whether or not there were rows in it,
//        // then uncomment this line below:
//        //return SectionHeaderHeight
//        // First check if there is a valid section of table.
//        // Then we check that for the section there is more than 1 row.
////        if let tableSection = TableSection(rawValue: section), let eventData = data[tableSection], eventData.count > 0 {
////            return SectionHeaderHeight
////        }
//        return SectionHeaderHeight
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
 //       view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.black
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .Running:
                label.text = "Running"
            case .Cycling:
                label.text = "Cycling"
            case .Basket:
                label.text = "Basket"
            case .Badminton:
                label.text = "Badminton"
            case .Futsal:
                label.text = "Futsal"
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        cell.data = data[TableSection.init(rawValue: indexPath.section)!]
        cell.index = indexPath.section
        cell.delegate = self
//        cell.labelName.text = self.data[TableSection.init(rawValue: indexPath.section)!]?[indexPath.row]
//        cell.ivSport.image = imageSport[indexPath.section][indexPath.row]
//        if let tableSection = TableSection(rawValue: indexPath.section), let event = data[tableSection]?[indexPath.row] {
////            if let titleLabel = cell.viewWithTag(10) as? UILabel {
////                titleLabel.text = ""
////            }
////            if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
////                subtitleLabel.text = ""
////            }
//
//        }
        return cell
    }
    
}

extension EventViewController : UITableViewDelegate{

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "toEventDetail", sender: self)
//    }
}

extension EventViewController : EventDelegate{
    func selectedEvent(name: String) {
        UserDefaults.standard.set(name, forKey: "Name")
        self.performSegue(withIdentifier: "toEventDetail", sender: self)
        
    }
    
}
