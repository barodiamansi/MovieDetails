//
//  ErrorManager.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/18/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

class ErrorManager {
    class func errorDisplayString(httpCode: Int) -> String {
        switch httpCode {
        case 400:
            return "Bad Request - Request cannot be fulfilled due to malformed syntax."
        case 401:
            return "Unauthorized - Request requires authorization." // API key missing.
        case 403:
            return "Forbidden - Refused to fulfil the request."
        case 404:
            return "Not found - No matching results were found."
        case 408:
            return "Timeout - Request was not produced within definite time."
        case 500:
            return "Internal Server Error - Server encountered unexpected condition."
        case 503:
            return "Service Unavailable - Server not responding maybe due to overloading or is under maintenance."
        default:
            return "Response returned with an error. Unhandled error code - \(httpCode)"
        }
    }
}
