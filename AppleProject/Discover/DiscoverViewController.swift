//
//  DiscoverViewController.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DiscoverViewController: UIViewController {

    let ref = Database.database().reference()
    var items : [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemRef = ref.child("Event")
        itemRef.observe(.value, with: { snapshot in
            var newItems : [Event] = []
            
            for child in snapshot.children{
                let snapshot = child as? DataSnapshot
                let item = Event(snapshot: snapshot!)
                newItems.append(item)
            }
            
            self.items = newItems
        })
    }

}

extension DiscoverViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverCell", for: indexPath)
        
        
        
        return cell
    }
    
    
}
