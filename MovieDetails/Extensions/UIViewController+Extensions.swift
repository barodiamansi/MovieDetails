//
//  UIViewController+Extensions.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/18/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     Creates and displays an alert object with title, message string and an OK button.
     
     - Parameter title: Title on the alert.
     - Parameter errorMessage: Error message that needs to be displayed on the alert.
     - Returns: An alert object of type UIAlertController.
     */
    open func displayAlert(title: String, errorMessage: String) {
        let alertController = UIAlertController(title: "\(title)", message: errorMessage, preferredStyle: .alert)
        let okText = NSLocalizedString("ok", comment: "Ok button text")
        alertController.addAction(UIAlertAction(title: "\(okText)", style: .default))
        self.present(alertController, animated: true)
    }
}
