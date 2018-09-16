//
//  AlertManager.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/16/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import UIKit

// Manages creation of an alert object with title, message string and an OK button.
class AlertManager {
    /**
     Creates an alert object with title, message string and an OK button.
     
     - Parameter title: Title on the alert.
     - Parameter errorMessage: Error message that needs to be displayed on the alert.
     - Returns: An alert object of type UIAlertController.
     */
    class func createAlert(title: String, errorMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: "\(title)", message: errorMessage, preferredStyle: .alert)
        let okText = NSLocalizedString("ok", comment: "Ok button text")
        alert.addAction(UIAlertAction(title: "\(okText)", style: .default))
        return alert
    }
}
