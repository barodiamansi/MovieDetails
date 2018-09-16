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
    
    let searchBar:UISearchBar = UISearchBar()
    
    var moviesList = [MovieDetailsData]()
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = NSLocalizedString("searchString", comment: "Search bar string")
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        self.movieListTable.dataSource = self
        self.movieListTable.delegate = self
        searchBar.delegate = self
        self.movieListTable.tableHeaderView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Clear the array and the table view and set page as 0.
        self.moviesList.removeAll()
        self.movieListTable.reloadData()
        searchBar.resignFirstResponder() 
        currentPage = 0
        loadReviews(searchText: searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if (searchBar.text?.count == 0) {
            self.movieListTable.reloadData()
            return true
        }
        
        return false
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
        }
    }
}

