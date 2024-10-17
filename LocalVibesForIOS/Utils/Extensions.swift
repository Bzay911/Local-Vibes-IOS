//
//  Extensions.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 28/7/2024.
//

import Foundation
import UIKit

// Funciton for checking blanks strings
extension Optional where Wrapped == String {
    var isBlank : Bool {
        guard let notNilBool = self else {
            return true
        }
        return notNilBool.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}

extension UIViewController {
    func showAlertMessage (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessageWithHandler(title: String, message: String, onComplete: (() -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let onCompleteAction: UIAlertAction = UIAlertAction(title: "OK", style: .default){ action in
            onComplete?()
        }
        
        alert.addAction(onCompleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteConfirmationMessage(title : String, message : String, delete : ( () -> Void )?, cancel: ( () -> Void )? ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .destructive) {
            action -> Void in delete?()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) {
            action -> Void in cancel?()
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
       
    
        present(alert, animated: true, completion: nil)
        
    }
}
