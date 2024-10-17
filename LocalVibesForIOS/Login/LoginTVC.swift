//
//  LoginTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 8/8/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginTVC: UITableViewController {

    
    
    @IBOutlet weak var loginEmailTextView: UITextField!
    @IBOutlet weak var loginPasswordTextView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    
    @IBAction func loginDidPress(_ sender: Any) {
        
        guard !loginEmailTextView.text.isBlank else {
            // show the user a message showing them the email cannot be blank
            showAlertMessage(title: "Validation", message: "Email is mandatory")
            return
        }
        
        guard !loginPasswordTextView.text.isBlank else {
            // show the user a message showing them the password cannot be blank
            showAlertMessage(title: "Validation", message: "Password is mandatory")
            return
        }
        
        let email = loginEmailTextView.text!
        let password = loginPasswordTextView.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard error == nil else{
                self?.showAlertMessage(title: "Failed to Login", message: "\(error!.localizedDescription)")
                return
            }
            
            guard let authUser = Auth.auth().currentUser, authUser.isEmailVerified else {
                self?.showAlertMessage(title: "Pending email verification", message: "We have sent you an email to verify your account, please follow the instructions")
                return
            }
            // I will let pass user to the next screen because the log in was done
            //            self?.showAlertMessage(title: "Welcome to my app", message: ":")
            
            let homeViewController = self?.storyboard?.instantiateViewController(identifier: "HomeVC") as? UITabBarController
            
            self?.view.window?.rootViewController = homeViewController
            self?.view.window?.makeKeyAndVisible()
        }
        
    }
    
    
    @IBAction func loginWithGoogleDidPress(_ sender: Any) {
    
        // Getting client id from firebase configuration
        let clientID = FirebaseApp.app()?.options.clientID
        
        // Creating google sign configuration object
        let config = GIDConfiguration(clientID: clientID!)
        
        GIDSignIn.sharedInstance.configuration = config
        
               GIDSignIn.sharedInstance.signIn(withPresenting: self){ [unowned self] result, error in
                   guard error == nil else {
                       self.showAlertMessage(title: "Failed to login", message: "\(error?.localizedDescription)")
                       return
                   }

                   guard let googleUser = result?.user,
                     let idToken = googleUser.idToken?.tokenString
                   else {
                       self.showAlertMessage(title: "Failed to login", message: "Failed to get user or Id token.")
                       return
                   }

                   let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                  accessToken: googleUser.accessToken.tokenString)

                   Auth.auth().signIn(with: credential) { result, error in
                       if let error = error {
                           self.showAlertMessage(title: "Failed To Login", message: "\(error.localizedDescription)")
                           
                       }
                       
                       let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? UITabBarController
                       self.view.window?.rootViewController = homeViewController
                       self.view.window?.makeKeyAndVisible()
                       
                                    
                                }
            }
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
