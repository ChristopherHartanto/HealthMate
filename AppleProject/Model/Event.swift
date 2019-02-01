//
//  Event.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Event {
    let name : String
    let date : String
    let sportType : String
    let place : String
    let gender : String
    let description : String
    let hostEvent : String
    
    init(name : String, date : String, sportType : String, place : String, gender : String, description : String, hostEvent : String) {
        self.name = name
        self.date = date
        self.sportType = sportType
        self.place = place
        self.gender = gender
        self.description = description
        self.hostEvent = hostEvent
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["Name"] as! String
        date = snapshotValue["Date"] as! String
        sportType = snapshotValue["SportType"] as! String
        place = snapshotValue["Place"] as! String
        gender = snapshotValue["Gender"] as! String
        description = snapshotValue["Description"] as! String
        hostEvent = snapshotValue["HostEvent"] as! String? ?? ""
    }
    
    func toAnyObject() -> Any {
        return [
            "Name" : name,
            "Date" : date,
            "SportType" : sportType,
            "Place" : place,
            "Gender" : gender,
            "Description" : description,
            "HostEvent" : hostEvent
        ]
    }
}
