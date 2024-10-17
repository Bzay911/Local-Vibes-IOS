//
//  ViewPostTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 4/8/2024.
//

import UIKit

class ViewPostTVC: UITableViewController {

    // creating instance of community
    var community: Community!
    
    @IBOutlet weak var viewPostImageView: UIImageView!
    @IBOutlet weak var viewPostFullName: UILabel!
    @IBOutlet weak var viewPostAddress: UILabel!
    @IBOutlet weak var viewPostDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting texts to the textfield
        viewPostFullName.text = community.posterFullName
        viewPostAddress.text = community.posterAddress
        viewPostDescription.text = community.postDetails
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let editPostTVC = segue.destination as? EditPostTVC{
            editPostTVC.community = community
        }
            
    }
    

}
