//
//  UIAlertController+Extension.swift
//  StartPlast
//
//  Created by Viktor Rudyk on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showAlert(withTitle title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        
        UIApplication.topViewController().present(alertController, animated: true, completion: nil)
    }
    
    static func showErrorAlert(withMessage message: String, okHandler: ((UIAlertAction)->Void)?) {
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: okHandler)
        
        UIAlertController.showAlert(withTitle: "Овва!", message: message, actions: [action])
    }
    
    static func showFatalErrorAlert(withMessage message: String) {
        let action = UIAlertAction(title: "Зрозуміло", style: .destructive) { _ in
            assertionFailure("-------->  FATAL ERROR: \(message)")
        }
        UIAlertController.showAlert(withTitle: "FATAL ERROR", message: "", actions: [action])
    }
}
