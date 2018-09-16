//
//  MovieDetailsData.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import ObjectMapper

// Handles mapping of the response objects.
struct MovieDetailsData: Mappable {
    var title = ""
    var headline = ""
    var releaseDate = ""
    var imageURL: URL?
    var summary = ""
    var articleURL: URL?
    var articleText = ""
    var author = ""
    var rating = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title       <- map["display_title"]
        headline    <- map["headline"]
        releaseDate <- map ["opening_date"]
        rating      <- map["mpaa_rating"]
        imageURL    <- (map["multimedia.src"], URLTransform())
        articleURL  <- (map["link.url"], URLTransform())
        articleText <- map["link.suggested_link_text"]
        summary     <- map["summary_short"]
        author      <- map["byline"]
    }
}
