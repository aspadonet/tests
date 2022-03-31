//
//  Alert.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 30.03.22.
//

import Foundation

import UIKit

struct Alert {
    private static func showSimpleAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showErrorAlert(vc: UIViewController,
                               title: String,
                               message: String,
                               completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showResultAlert(vc: UIViewController, message: String) {
        showSimpleAlert(vc: vc, title: "Result", message: message)
    }
    static func showErrorAlert(vc: UIViewController, message: String, completion: @escaping() -> Void) {
        
        showErrorAlert(vc: vc, title: "Error", message: message, completion: completion)
    }
    
}
