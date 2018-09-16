//
//  MovieListViewController.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit
import MBProgressHUD

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
        self.moviesList.removeAll()
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
    
    private func registerNibs() {
        movieListTable.register(UINib(nibName: MovieInfoCell.reusableID, bundle: nil), forCellReuseIdentifier: MovieInfoCell.reusableID)
    }
    
    private func loadReviews(searchText: String) {
        self.showHUD(show: true)
        ServiceRequestor().getNYTimesMovies(page: currentPage, queryText: searchText, onSuccess: { reviews in
            if (reviews.count > 0) {
                self.moviesList.append(contentsOf: reviews)
                self.movieListTable.reloadData()
                self.showHUD(show: false)
                self.currentPage += 1
            }
            else {
                self.showHUD(show: false)
            }
        }, onFailure: { error in
            self.showHUD(show: false)
            print(error)
        })
    }
    
    private func showHUD(show: Bool) {
        switch show {
        case true:
            movieListTable.separatorStyle = .none
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = NSLocalizedString("loading", comment: "Activity indicator text")
        case false:
            movieListTable.separatorStyle = .singleLine
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetails" {
            let controller = (segue.destination as? MovieDetailsViewController)!
            controller.movieDetails = sender as? MovieDetailsData
        }
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
}

