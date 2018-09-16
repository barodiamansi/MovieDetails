//
//  ApiKeys.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

class ApiKeys {
    // Wrapper for obtaining keys from keys.plist
    class func valueForAPIKey(keyname:String) -> String {
        // Get the file path for keys.plist
        let filePath = Bundle.main.path(forResource: "keys", ofType: "plist")
        
        // Put the keys in a dictionary
        let plist = NSDictionary(contentsOfFile: filePath!)
        
        // Pull the value for the key
        let value:String = plist?.object(forKey: keyname) as! String
        
        return value
    }
}
