//
//  ShowOrganisersTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 30/7/2024.
//

import UIKit
import FirebaseAuth

class ShowOrganisersTVC: UITableViewController {
    
    var service = Repository()
    var organisers = [Organiser]()
    
    @IBOutlet var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("I am in show organisers")
        
        let userAuthId = Auth.auth().currentUser?.uid
        
        service.showOrganisers(fromCollection: "Organisers"){ (returnedCollection) in
            self.organisers = returnedCollection
            print("inside total \(self.organisers.count)")
            // Reload the tableview
            self.contactsTableView.reloadData()
        }
            
        
        print("total \(organisers.count)")
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organisers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! OrganiserTVCell

        // Configure the cell...
        let organiser = organisers[indexPath.row]
        
        cell.usernameLabel.text = organiser.username
        
        if !organiser.image.isEmpty && UIImage(named: organiser.image) != nil{
            cell.organiserImageView.image = UIImage(named: organiser.image)
        }else{
            cell.organiserImageView.image = UIImage(systemName: "person.circle.fill")
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            let orgainser = organisers[indexPath.row]
            deleteConfirmationMessage(title:"Delete",
                                      message: "Do you want to permanently delete the organiser?",
                                         delete: {
                if self.service.deleteOrganiser(withOrganiserId: orgainser.id){
                                                print("Organiser deleted")
                                                }
                                                  },
                                      cancel: {
                
                                               })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // Exiting all screens in between and reaching the destination screen
    @IBAction func unwindToShowOrganisersTVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
