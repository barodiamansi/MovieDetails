//
//  ApiKeys.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

// Wrapper for obtaining key value from keys.plist. Valid key name is required.
class ApiKeys {
    /**
     Looks for the keyname in keys plist file and returns value of it.
     
     - Parameter keyname: Name of the key in plist file. Key name should be valid.
     - Returns: Value of the provided key as string.
     */
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
