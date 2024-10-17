//
//  EditPostTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 5/8/2024.
//

import UIKit
import FirebaseAuth

class EditPostTVC: UITableViewController {

    var community : Community!
    
    let service = Repository()
    
    @IBOutlet weak var editPostImageView: UIImageView!
    @IBOutlet weak var editPostFullNameTextField: UITextView!
    @IBOutlet weak var editPostAddressTextField: UITextView!
    @IBOutlet weak var editPostPostDescriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        editPostFullNameTextField.text = community.posterFullName
        editPostAddressTextField.text = community.posterAddress
        editPostPostDescriptionTextField.text = community.postDetails
        
        print("I am inside edit post")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let showCommunityTVC = segue.destination as? ShowCommunityTVC {
            // updating the community page
            community.posterFullName = editPostFullNameTextField.text!
            community.posterAddress = editPostAddressTextField.text!
            community.postDetails = editPostPostDescriptionTextField.text!
            
            let userAuthId = Auth.auth().currentUser?.uid
            if service.updateCommunityPost(for:userAuthId!, withData: community){
                print("We are happy now, it was successfully updated")
            }
        }
    }
    

}
