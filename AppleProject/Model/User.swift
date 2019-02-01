//
//  People.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    let name : String
    let primarySport : String
    let city : String
    let gender : String
    
    init(name : String?, primarySport : String, city : String,
         gender : String) {
        self.name = name!
        self.primarySport = primarySport
        self.city = city
        self.gender = gender
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["Name"] as! String
        primarySport = snapshotValue["PrimarySport"] as! String
        city = snapshotValue["City"] as! String
        gender = snapshotValue["Gender"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "Name" : name,
            "PrimarySport" : primarySport,
            "City" : city,
            "Gender" : gender
        ]
    }
}

