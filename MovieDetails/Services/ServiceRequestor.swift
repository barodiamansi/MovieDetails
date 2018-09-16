//
//  ServiceRequest.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

// Deals with sending service request and collecting the response.
class ServiceRequestor {
    /**
     Handles the request and the response for search movie review service defined by NY Times developer API.
     
     - Parameter page: Used for paging, specifies the page number which will then be multiplied by 20 since the service accepts offset in multiples of 20.
     - Parameter queryText: User input text used for movie-review search.
     - Parameter onSuccess: Callback in case of successfull response.
     - Parameter onFailure: Callback in case of failed response.
     */
    func getNYTimesMovies(page: Int, queryText: String, onSuccess: @escaping([MovieDetailsData]) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(ServiceRouter.getNYTimesMovies(page: page, queryText: queryText))
            .validate()
            .responseObject { (response: DataResponse<MovieDetailsResponse>) in
                switch response.result {
                case .success:
                    let movies = response.result.value
                    if let moviesList = movies?.movieDetails {
                        onSuccess(moviesList)
                    }
                case .failure(let error):
                    onFailure(error)
                }
        }
    }
}
