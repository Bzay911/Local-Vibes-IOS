//
//  Repository.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 30/7/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Repository{
    
    var db = Firestore.firestore()
    
    // Displaying organisers
    func showOrganisers(fromCollection name: String, completion: @escaping(([Organiser]) -> ())){
        var organisers = [Organiser]()
        
        db.collection(name)
            .addSnapshotListener{snapshot, error in
                if let documents = snapshot?.documents{
                    organisers = documents.compactMap({doc -> Organiser? in
                        let data = doc.data()
                        return Organiser(id: doc.documentID, dictionary: data)
                    })
                    
                    // loop is done
                  completion(organisers)
                }else{
                    print("Error fetching documents \(error!)")
                    return
                }
            }
    }
    
    // Adding an organiser
    func addOrganiser(withData organiser: Organiser) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "username" : organiser.username,
            "image" : organiser.image
        ]
        
        let organiserRef = db.collection("Organisers").document()
        
        organiserRef.setData(dictionary){error in
            if let error = error{
                print("Error adding organiser \(error.localizedDescription)")
                result = false
            }else{
                print("New organiser added successfully")
            }
        }
        return result
    }
    
    // Updating an organiser
    func updateOrgansier(withData organiser: Organiser) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "username" : organiser.username,
            "image" : organiser.image
        ]
        db.collection("Organisers").document()
        .updateData(dictionary){error in
            if let error = error{
                print("Error updating organiser \(error.localizedDescription)")
                result = false
            }else{
                print("Organiser updated successfully")
            }
        }
        return result
    }
    
    // Deleting an organiser
    func deleteOrganiser(withOrganiserId organiserId: String) -> Bool{
        var result = true
        
        db.collection("Organisers").document(organiserId).delete(){error in
            if let error = error {
                print("Error deleting organiser \(error.localizedDescription)")
                result = false
            }
            else{
                print("Organiser deleted successfully")
            }
        }
        return result
    }
    
    // Displaying events
    func showEvents(fromCollection name: String, completion: @escaping(([Event]) -> ())){
        var events = [Event]()
        
        db.collection(name)
            .addSnapshotListener{snapshot, error in
                if let documents = snapshot?.documents{
                    events = documents.compactMap({doc -> Event? in
                        let data = doc.data()
                        return Event(id: doc.documentID, dictionary: data)
                    })
                    
                    // loop is done
                  completion(events)
                }else{
                    print("Error fetching documents \(error!)")
                    return
                }
            }
    }
    
    // Adding an event
    func addEvent(withData event: Event) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "eventDate" : event.eventDate,
            "eventTitle" : event.eventTitle,
            "eventVenue" : event.eventVenue
        ]
        
        let eventRef = db.collection("Events").document()
        
        eventRef.setData(dictionary){error in
            if let error = error{
                print("Error adding event \(error.localizedDescription)")
                result = false
            }else{
                print("New event added successfully")
            }
        }
        return result
    }
    
    // Updating an event
    func updateEvent(for userId:String, withData event: Event) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "eventDate" : event.eventDate,
            "eventTitle" : event.eventTitle,
            "eventVenue" : event.eventVenue
        ]
        db.collection("Events").document(event.id)
        .updateData(dictionary){error in
            if let error = error{
                print("Error updating event \(error.localizedDescription)")
                result = false
            }else{
                print("Event updated successfully")
            }
        }
        return result
    }
    
    // Deleting an event
    func deleteEvent(withEventId eventId: String) -> Bool{
        var result = true
        
        db.collection("Events").document(eventId).delete(){error in
            if let error = error {
                print("Error deleting event \(error.localizedDescription)")
                result = false
            }
            else{
                print("Event deleted successfully")
            }
        }
        return result
    }
    
    // Displaying community posts
    func showCommunity(fromCollection name: String, completion: @escaping(([Community]) -> ())){
        var community = [Community]()
        
        db.collection(name)
            .addSnapshotListener{snapshot, error in
                if let documents = snapshot?.documents{
                    community = documents.compactMap({doc -> Community? in
                        let data = doc.data()
                        return Community(id: doc.documentID, dictionary: data)
                    })
                    
                    // loop is done
                  completion(community)
                }else{
                    print("Error fetching documents \(error!)")
                    return
                }
            }
    }
    
    // adding a community post
    func addCommunityPost(withData community: Community) -> Bool{
        
        var result = true
        let dictionary: [String: Any] = [
            "postDetails" : community.postDetails,
            "postImage" : community.postImage,
            "posterFullName" : community.posterFullName,
            "posterAddress" : community.posterAddress
        ]
        
        let communityRef = db.collection("Community").document()
        
        communityRef.setData(dictionary){error in
            if let error = error{
                print("Error adding community post \(error.localizedDescription)")
                result = false
            }else{
                print("Community post added successfully")
            }
            
        }
        
        return result
    }
    
    // Updating a community post
    func updateCommunityPost(for userId: String, withData community: Community) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "postDetails" : community.postDetails,
            "postImage" : community.postImage,
            "posterFullName" : community.posterFullName,
            "posterAddress" : community.posterAddress
        ]
        
        db.collection("Community").document(community.id).updateData(dictionary){error in
            if let error = error {
                print("Error updating community post \(error.localizedDescription)")
                result = false
            }
            else{
                print("Community post updated successfully")
            }
        }
        
        return result
    }
    
    // Deleting a community post
    func deleteCommunityPost(withPostId postId: String) -> Bool{
        var result = true
        
        db.collection("Community").document(postId).delete(){error in
            if let error = error {
                print("Error deleting community post \(error.localizedDescription)")
                result = false
            }
            else{
                print("Community post deleted successfully")
            }
        }
        return result
    }
    
    // Adding User
    func addUser(withData user: User) -> Bool {
        
        var result = true
        
        var dictionary: [String: Any] = [
            "firstname":  user.firstname,
            "lastname": user.lastname,
            "email": user.email,
            "address":user.address
        ]
        
        db.collection("Users").document(user.id).setData(dictionary) { error in
            
            if let err = error {
                print("user could not be added \(user.email), \(err)")
                result = false
            }
        }
         return result
    }
    
    // Getting user
    func getUser(for userId: String, completion: @escaping((User?) -> ())){
        var user: User
        db.collection("Users").document(Auth.auth().currentUser!.uid).getDocument{snapshot, error in
            if let error = error{
                completion(nil)
                return
            }
            guard let snapshot = snapshot, let data = snapshot.data() else{
                completion(nil)
                return
            }
            let user = User(id: snapshot.documentID, dictionary: data)
            completion(user)
        }
    }
    
    // Updating user profile
    func updateUserProfile(for userId: String, withData user: User) -> Bool{
        var result = true
        let dictionary: [String: Any] = [
            "firstname" : user.firstname,
            "lastname" : user.lastname,
            "email" : user.email,
            "address" : user.address
        ]
        
        db.collection("Users").document(user.id).updateData(dictionary){error in
            if let error = error {
                print("Error updating user \(error.localizedDescription)")
                result = false
            }
            else{
                print("User updated successfully")
            }
        }
        
        return result
    }
    
}
