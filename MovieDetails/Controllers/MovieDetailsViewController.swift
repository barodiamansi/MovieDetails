//
//  MovieDetailsViewController.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UITableViewController {
    var movieDetails: MovieDetailsData?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var articleURLLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let review = movieDetails else {
            return
        }
        titleLabel.text = review.title
        if let url = review.imageURL {
            movieImage.af_setImage(withURL: url)
        }
        else {
            movieImage.image = UIImage(named: "placeholder.png")
        }
        
        headlineLabel.text = review.headline
        
        let authorText = NSLocalizedString("author", comment: "Author label text")
        authorLabel.text = "\(authorText): \(review.author)"
        
        let date = review.releaseDate as String?
        let releaseDateText = NSLocalizedString("release date", comment: "Release date label text")
        let tbaText = NSLocalizedString("tba", comment: "TBA text")
        releaseDateLabel.text = "\(releaseDateText): \(String(describing: date != "" ? Date.getMMMddyyyyDateFormat(date!) : "\(tbaText)"))"
        
        summaryLabel.text = review.summary
        
        let mpaaRatingText = NSLocalizedString("mpaa rating", comment: "MPAA rating label text")
        mpaaRatingLabel.text = "\(mpaaRatingText): \(review.rating != "" ? review.rating : "--")"
        articleURLLabel.text = "\(review.articleText) >>"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webPage" {
            let controller = (segue.destination as? WebViewController)!
            controller.articleURL = movieDetails?.articleURL
        }
    }
}

