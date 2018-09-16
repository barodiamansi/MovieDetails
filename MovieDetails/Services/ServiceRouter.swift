//
//  ServiceRouter.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import Alamofire

// Defines path, params and HTTP methods for individual service calls. Also creates request URL.
enum ServiceRouter: URLRequestConvertible {
    
    case getNYTimesMovies(page: Int, queryText: String)
    
    var path: String {
        switch self {
        case .getNYTimesMovies:
            return ServiceApiManager.movieReviewsPath
        }
    }
    var parameters: [String: Any] {
        switch self {
        case .getNYTimesMovies(let page, let queryText):
            return ["offset": ServiceApiManager.resultsPerPage*page, "api-key": ServiceApiManager.key, "query": queryText]
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getNYTimesMovies:
            return .get
        }
    }
    
    // Creates service URL request. Throws an error if URL is nil.
    func asURLRequest() throws -> URLRequest {
        let url = try ServiceApiManager.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)
    }
}
