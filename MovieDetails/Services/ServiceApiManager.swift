//
//  ServiceApiManager.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation

// Manages the Service API configuration details.
struct ServiceApiManager {
    // Base URL of the api.
    static let baseURL = "https://api.nytimes.com/svc/movies/v2"
    
    // Api key required to access the API.
    static let key = ApiKeys.valueForAPIKey(fileName: "keys", keyName: "MovieReviewAPIKey")
    
    // Number of results that would be returned per call.
    static let resultsPerPage = 20
    
    // Service URI for movie reviews.
    static let movieReviewsPath = "reviews/search.json"
}
