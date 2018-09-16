//
//  UITableViewCell+ReusableID.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reusableID: String {
        return String(describing: self)
    }
}
