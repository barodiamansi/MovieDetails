//
//  MovieDetailsViewControllerTests.swift
//  MovieDetailsTests
//
//  Created by Barodia,Mansi on 9/19/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDetails

class MovieDetailsViewControllerTests: XCTest {
    func testViewDidLoad() {
        var movieDetails: MovieDetailsData!
        movieDetails.title = "The is title."
        movieDetails.headline = "This is a headline."
        movieDetails.imageURL = URL(string: "https://www.apple.com")
        movieDetails.summary = "The is summary."
        movieDetails.articleURL = URL(string: "https://www.google.com")
        movieDetails.articleText = "This is article text."
        movieDetails.author = "This is author."
        movieDetails.rating = "PG"
        movieDetails.releaseDate = "2017-12-20"
        
        let controller = MovieDetailsViewController()
        controller.movieDetails = movieDetails
        controller.viewDidLoad()
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller.titleLabel.text, movieDetails.title)
        XCTAssertEqual(controller.headlineLabel.text, movieDetails.headline)
        XCTAssertNotNil(controller.movieImage.image)
        XCTAssertEqual(controller.releaseDateLabel.text, "Dec 12, 2017")
        XCTAssertEqual(controller.articleURLLabel.text, movieDetails.articleText)
        XCTAssertEqual(controller.authorLabel.text, movieDetails.author)
        XCTAssertEqual(controller.mpaaRatingLabel.text, movieDetails.rating)
        XCTAssertEqual(controller.navigationItem.title, "Movie Details")
    }
}
