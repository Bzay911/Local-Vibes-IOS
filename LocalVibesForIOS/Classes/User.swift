//
//  User.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 30/7/2024.
//

import Foundation
import FirebaseFirestore

class User {
    var id: String!
    var firstname: String
    var lastname: String
    var address: String
    var email: String
 
    
    init(id: String!, firstname: String!, lastname: String!, address: String!, email: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.address = address
        self.email = email
    
    }

    convenience init(id: String, dictionary: [String: Any]){
        self.init(id: id,
                  firstname: dictionary["firstname"] as! String,
                  lastname: dictionary["lastname"] as! String,
                  address: dictionary["address"] as! String,
                  email: dictionary["email"] as! String
         
        )
    
        
    }
   
}

