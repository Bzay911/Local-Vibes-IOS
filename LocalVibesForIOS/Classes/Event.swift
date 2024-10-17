//
//  Event.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 3/8/2024.
//

import Foundation
import FirebaseFirestore

class Event{
    var id: String!
    var eventTitle: String
    var eventVenue: String
    var eventDate: String
    
    init(eventTitle: String, eventVenue: String, eventDate: String) {
        self.eventTitle = eventTitle
        self.eventVenue = eventVenue
        self.eventDate = eventDate
    }
    
    convenience init(id: String, eventTitle: String, eventVenue: String, eventDate: String){
        self.init(eventTitle: eventTitle, eventVenue: eventVenue, eventDate: eventDate)
        self.id = id
    }
    
    convenience init (id: String){
        self.init(eventTitle: "", eventVenue: "", eventDate: "")
        self.id = id
    }
    
    convenience init(id: String, dictionary: [String: Any]){
        self.init(id: id,
                  eventTitle: dictionary["eventTitle"] as! String,
                  eventVenue: dictionary["eventVenue"] as! String,
                  eventDate: dictionary["eventDate"] as! String)
    }
    
}
