//
//  UIKit Extensions.swift
//  KD Tiktok-Clone
//
//  RoadTrips
//
//  Created by Maram Al shahrani on 19/04/1443 AH.
//
import Foundation
import UIKit


// MARK: - UIViewController
extension UIViewController{
    
    /// Display an alert view if the function is not implemented
    func showAlert(_ message: String, title: String? = nil){
        // Check if one has already presented
        if let currentAlert = self.presentedViewController as? UIAlertController {
            currentAlert.message = message
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)


    }
}


