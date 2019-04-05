//
//  UIViewController+Alert.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

import UIKit

@objc extension UIViewController {
    
    /**
     Show an alert message error to the user.
     
     - parameters:
        - message: String message to explain the error. Can be nil. In this case message is just "Error".
    */
    func showAlertError(message: String?) {
        let alert = UIAlertController(title: DZRTranslation.defaultError, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DZRTranslation.defaultOk, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
