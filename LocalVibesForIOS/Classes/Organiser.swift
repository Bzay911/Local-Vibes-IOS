//
//  Organiser.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 30/7/2024.
//

import Foundation
import FirebaseFirestore

class Organiser {
    var id: String!
    var username: String
    var image: String
//    var registered: Timestamp
    
    init(username: String, image: String){
       self.username = username
       self.image = image
   }
    
     convenience init(id: String, username: String, image: String) {
         self.init(username: username, image: image)
         self.id = id
    }

    // get info of organiser using this init
    convenience init(id: String){
        self.init(username: "", image: "")
        self.id = id
    }
    
    convenience init(id: String, dictionary: [String: Any]){
        self.init(id: id,
                  username: dictionary["username"] as! String,
                  image: dictionary["image"] as! String
        )
    }
    
    // Todo
//    convenience init(id: String, dictionary:[String: Any]){
//
//    }
    
}

