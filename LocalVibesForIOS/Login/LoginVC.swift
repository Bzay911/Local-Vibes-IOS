//
//  LoginVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 27/7/2024.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginDidPress(_ sender: Any) {
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
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
