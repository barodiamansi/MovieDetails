//
//  Date+Extensions.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/16/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

extension Date {
    /**
     Formats the date provided with yyyy-mm-dd format to MMM dd, yyyy format. Returns '--' if the date is not valid (eg: 0000-00-00).
     
     - Parameter stringDate: String date in yyyy-mm-dd format.
     - Returns: String date in MMM dd, yyyy format.
     */
    public static func getMMMddyyyyDateFormat(_ stringDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        guard let dateObj = dateFormatter.date(from: stringDate) else {
            return "--"
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: dateObj)
    }
}
