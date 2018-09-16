//
//  Date+Extensions.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/16/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

extension Date {
    public static func getMMMddyyyyDateFormat(_ stringDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        guard let dateObj = dateFormatter.date(from: stringDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: dateObj)
    }
}
