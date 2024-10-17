//
//  SignUpTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 8/8/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignUpTVC: UITableViewController {
    
    @IBOutlet weak var signupEmailTextField: UITextField!
    @IBOutlet weak var signupPasswordTextField: UITextField!
    @IBOutlet weak var signupConfirmPasswordTextField: UITextField!
    
    var service = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func signUpDidPress(_ sender: Any) {
        guard !signupEmailTextField.text.isBlank else {
                   // show the user a message showing them the email cannot be blank
                   showAlertMessage(title: "Validation", message: "Email is mandatory")
                   return
               }
               
               guard !signupPasswordTextField.text.isBlank else {
                   // show the user a message showing them the password cannot be blank
                   showAlertMessage(title: "Validation", message: "Password is mandatory")
                   return
               }
               
               guard !signupConfirmPasswordTextField.text.isBlank else {
                   // show the user a message showing them the confrimPassword cannot be blank
                   showAlertMessage(title: "Validation", message: "Password Confirmation is mandatory")
                   return
               }
        
              guard let email = signupEmailTextField.text,
              let password = signupPasswordTextField.text,
              let confirmation = signupConfirmPasswordTextField.text,
              password == confirmation else{
            showAlertMessage(title: "Validation", message: "Password and Confirmation Password do not match")
            return
        }
        
            // Creating a closure to execute as soon as the user acknowledge the confirmation email message
            let registeredUserClosure : () -> Void = {
                
            // Getting the user id
            let userAuthId = Auth.auth().currentUser?.uid
            print("Signed up user id \(userAuthId ?? "NIL")")
    
            // Creating user object to save it inside the cloud firestore inside the Users  collection
            let user = User(id: userAuthId,
                    firstname: "",
                    lastname: "",
                    address: "",
                    email: email
//                      registered: <#T##Timestamp!#> // we can omit it as its declared as a param with default values
                        )
    if self.service.addUser(withData: user){
        print("User added \(user.email)")
    }
    
    self.navigationController?.popViewController(animated: true)
}

       // user firebase auth
       Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
           guard error == nil else{
               self.showAlertMessage(title: "We could not create the account", message: "\(error?.localizedDescription)")
               return
           }
           // send an email confirmation
           Auth.auth().currentUser?.sendEmailVerification(){error in
               if let error = error {
                   self.showAlertMessage(title: "Error", message: "\(error.localizedDescription)")
                   return
               }
           }
           self.showAlertMessageWithHandler(title: "Email Confirmation Sent", message: "A confirmation email has been sent to your email account", onComplete: registeredUserClosure)
       }
    }
    
    
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
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
