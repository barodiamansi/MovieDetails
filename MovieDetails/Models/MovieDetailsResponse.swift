//
//  MovieDetailsResponse.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import ObjectMapper

// Deals with mapping the response result object.
struct MovieDetailsResponse: Mappable {
    var movieDetails: [MovieDetailsData]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        movieDetails <- map["results"]
    }
}

