import UIKit
import FirebaseAuth

class ProfileTVC: UITableViewController {
    
    var user: User!
    var service = Repository()
    let userAuthId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var profileFullName: UILabel!
    @IBOutlet weak var profileEmailAddress: UILabel!
    @IBOutlet weak var profileUserAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting default values for the labels
        profileFullName.text = "Full Name"
        profileEmailAddress.text = "Email Address"
        profileUserAddress.text = "User Address"
        
        // Fetch user data from Firebase
        if let userId = userAuthId {
            service.getUser(for: userId) { returnedUser in
                self.user = returnedUser
                
                // Update UI with the fetched user data
                DispatchQueue.main.async {
                    self.profileFullName.text = self.user.firstname + " " + self.user.lastname
                    self.profileEmailAddress.text = self.user.email
                    self.profileUserAddress.text = self.user.address
                }
            }
        }
    }
    
    
    @IBAction func signOutBtnDidPress(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()

            // navigating user to login page after sign out
            if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginTVC") {
                    loginViewController.modalPresentationStyle = .fullScreen
                    present(loginViewController, animated: true, completion: nil)
                }
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, number
}
