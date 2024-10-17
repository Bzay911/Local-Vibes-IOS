//
//  Community.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 3/8/2024.
//

import Foundation
import FirebaseFirestore

class Community{
    var id: String!
    var postImage: String
    var postDetails: String
    var posterFullName: String
    var posterAddress: String
    
    init(postImage: String, postDetails: String, posterFullName: String, posterAddress: String) {
        self.postImage = postImage
        self.postDetails = postDetails
        self.posterFullName = posterFullName
        self.posterAddress = posterAddress
    }
    
    convenience init(id: String, postImage: String, postDetails: String, posterFullName: String, posterAddress: String){
        self.init(postImage: postImage, postDetails: postDetails, posterFullName: posterFullName, posterAddress: posterAddress)
        self.id = id
    }
    
    convenience init(id: String){
        self.init(postImage: "", postDetails: "", posterFullName:"", posterAddress: "")
        self.id = id
    }
    
    convenience init(id: String, dictionary: [String: Any]){
        self.init(id: id,
                  postImage: dictionary["postImage"] as! String,
                  postDetails: dictionary["postDetails"] as! String,
                  posterFullName: dictionary["posterFullName"] as! String,
                  posterAddress: dictionary["posterAddress"] as! String)
    }
}
