//
//  MovieListViewController.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var movieListTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackView: UIStackView!
    
    // Hold the movies list received as part of the response.
    var moviesList = [MovieDetailsData]()
    
    // Used for paging. Will be increased as and when a response is received.
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        searchBar.placeholder = NSLocalizedString("searchString", comment: "Search bar string")
        searchBar.isTranslucent = false
        self.movieListTable.dataSource = self
        self.movieListTable.delegate = self
        searchBar.delegate = self
        
        self.navigationItem.title = NSLocalizedString("movies_list_view_title", comment: "Movie list title")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Clear the movie list, the table view and set page count back to 0.
        self.moviesList.removeAll()
        self.movieListTable.reloadData()
        searchBar.resignFirstResponder()
        currentPage = 0
        loadReviews(searchText: searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // Clears out the table view when cancel on search bar is clicked.
        if (searchBar.text?.count == 0) {
            self.moviesList.removeAll()
            self.movieListTable.reloadData()
            self.movieListTable.separatorStyle = .none
        }
        return true
    }
    
    // Registers the nil with reusable ID.
    private func registerNibs() {
        movieListTable.register(UINib(nibName: MovieInfoCell.reusableID, bundle: nil), forCellReuseIdentifier: MovieInfoCell.reusableID)
    }
    
    /**
     Handles sending the request and then displaying the data on table view in case of a successful response from service request or displays an alert incase of failure.
     
     - Parameter searchText: User input text to query for the movies.
     */
    private func loadReviews(searchText: String) {
        self.movieListTable.separatorStyle = .none
        HUDManager.showHUD(show: true, view: self.view)
        ServiceRequestor().getNYTimesMovies(page: currentPage, queryText: searchText, onSuccess: { reviews in
            if (reviews.count > 0) {
                self.moviesList.append(contentsOf: reviews)
                self.movieListTable.reloadData()
                self.movieListTable.separatorStyle = .singleLine
                HUDManager.showHUD(show: false, view: self.view)
                self.currentPage += 1
            }
            else {
                HUDManager.showHUD(show: false, view: self.view)
            }
        }, onFailure: { error in
            print(error)
            HUDManager.showHUD(show: false, view: self.view)
            let loadFailText = NSLocalizedString("load failed", comment: "Service request failed")
            self.present(AlertManager.createAlert(title: loadFailText, errorMessage: error.localizedDescription), animated: true)
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetails", sender: moviesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.reusableID, for: indexPath) as? MovieInfoCell)!
        let review = moviesList[indexPath.row]
        cell.configure(with: review)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCell = moviesList.count - 1
        if lastCell == indexPath.row {
            loadReviews(searchText: searchBar.text!)
        }
    }
    
    // Navigates to details controller with movie details data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetails" {
            let controller = (segue.destination as? MovieDetailsViewController)!
            controller.movieDetails = sender as? MovieDetailsData
            controller.navigationItem.title = NSLocalizedString("movie_details_view_title", comment: "Movie details title")
        }
    }
}

