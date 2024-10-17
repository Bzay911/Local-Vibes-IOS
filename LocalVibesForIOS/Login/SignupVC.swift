//
//  SignupVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 27/7/2024.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var service = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupDidPress(_ sender: Any) {
        guard !emailTextField.text.isBlank else {
                   // show the user a message showing them the email cannot be blank
                   showAlertMessage(title: "Validation", message: "Email is mandatory")
                   return
               }
               
               guard !passwordTextField.text.isBlank else {
                   // show the user a message showing them the password cannot be blank
                   showAlertMessage(title: "Validation", message: "Password is mandatory")
                   return
               }
               
               guard !confirmPasswordTextField.text.isBlank else {
                   // show the user a message showing them the confrimPassword cannot be blank
                   showAlertMessage(title: "Validation", message: "Password Confirmation is mandatory")
                   return
               }
               
               guard let email = emailTextField.text,
                     let password = passwordTextField.text,
                     let confirmation = confirmPasswordTextField.text,
                     password == confirmation else{
                   showAlertMessage(title: "Validation", message: "Password and Confirmation Password do not match")
                   return
               }
               
                // Creating a closure to execute as soon as the user acknowledge the confirmation email message
        let registeredUserClosure : () -> Void = {
            // Getting the user id
            
            let userAuthId = Auth.auth().currentUser?.uid
            print("Signed up user id \(userAuthId ?? "NIL")")
            
            // Creating user object to save it inside the cloud firestore inside the Users collection
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
