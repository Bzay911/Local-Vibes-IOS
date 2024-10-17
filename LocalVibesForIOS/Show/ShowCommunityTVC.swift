//
//  ShowCommunityTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 3/8/2024.
//

import UIKit

class ShowCommunityTVC: UITableViewController {
    var selectedPost : Community!
    var service = Repository()
    var community = [Community]()
   
    
    @IBOutlet var communityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I am inside community section")
        
        service.showCommunity(fromCollection: "Community"){ (returnedCollection) in
            self.community = returnedCollection
            print("inside total \(self.community.count)")
            self.communityTableView.reloadData()
        }
        
        print("total \(community.count)")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return community.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath) as! ShowCommunityTVCell

        // Configure the cell...
        let communitycell = community[indexPath.row]
       
        cell.communityPosterFullName.text = communitycell.posterFullName
        
        cell.communityPosterAddress.text = communitycell.posterAddress
        
        cell.communityPostDetails.text = communitycell.postDetails
        
        if !communitycell.postImage.isEmpty && UIImage(named: communitycell.postImage) != nil{
            cell.communityImageView.image = UIImage(named: communitycell.postImage)
        }
        else{
            cell.communityImageView.image = UIImage(systemName: "person.circle.fill")
        }

        return cell
       
    }
   
    // returnig indexpath to know which post is selected
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedPost = community[indexPath.row]
        return indexPath
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
            //tableView.deleteRows(at: [indexPath], with: .fade)
            let community = community[indexPath.row]
            
            deleteConfirmationMessage(title:"Delete",
                                         message: "Do you want to permanently delete \(community.posterFullName)'s post?",
                                         delete: {
                                            if self.service.deleteCommunityPost(withPostId: community.id){
                                                print("Community post deleted")
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
        
        //passing community data
        if let viewPostTVC = segue.destination as? ViewPostTVC {
            viewPostTVC.community = selectedPost
        }
   }
    
    // Exiting all screens in between and reaching the destination screen
    @IBAction func unwindToShowCommunityTVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    

}
