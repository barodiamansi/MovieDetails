//
//  ErrorManagerTests.swift
//  MovieDetailsTests
//
//  Created by Mansi Barodia on 9/19/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import XCTest
@testable import MovieDetails

class ErrorManagerTests: XCTestCase {
    func testErrorDisplayString() {
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 1000), "Response returned with an error. Unhandled error code - 1000")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 400), "Bad Request - Request cannot be fulfilled due to malformed syntax.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 401), "Unauthorized - Request requires authorization.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 403), "Forbidden - Refused to fulfil the request.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 404), "Not found - No matching results were found.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 408), "Timeout - Request was not produced within definite time.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 500), "Internal Server Error - Server encountered unexpected condition.")
        
        XCTAssertEqual(ErrorManager.errorDisplayString(httpCode: 503), "Service Unavailable - Server not responding maybe due to overloading or is under maintenance.")
    }
}
