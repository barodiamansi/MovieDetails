//
//  MovieInfoCell.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieInfoCell: UITableViewCell {
  @IBOutlet weak var thumbnailImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var headlineLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  func configure(with movieDetail: MovieDetailsData) {
    if let url = movieDetail.imageURL {
        thumbnailImage.af_setImage(withURL: url)
    }
    else {
        thumbnailImage.image = UIImage(named: "placeholder.png")
    }
    
    movieTitle.text = movieDetail.title
    headlineLabel.text = movieDetail.headline
    let date = movieDetail.releaseDate as String?
    let releaseDateText = NSLocalizedString("release date", comment: "Release date label text")
    let tbaText = NSLocalizedString("tba", comment: "TBA text")
    releaseDateLabel.text = "\(releaseDateText): \(String(describing: date != "" ? Date.getMMMddyyyyDateFormat(date!) : "\(tbaText)" ))"
  }
}
