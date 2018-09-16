//
//  HUDManager.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/16/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import MBProgressHUD

// Manages showing and hiding of HUD on a particular view with a localized 'Loading' string.
class HUDManager {
    /**
     Displays and hides HUD.
     
     - Parameter show: True if HUD needs to be displayed, else false.
     - Parameter view: View on which HUD needs to be displayed.
     */
    class func showHUD(show: Bool, view: UIView) {
        switch show {
        case true:
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = NSLocalizedString("loading", comment: "Activity indicator text")
        case false:
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
