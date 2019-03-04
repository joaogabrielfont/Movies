//
//  MoviesTableViewCell.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 04/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    var genders: String = ""

    @IBOutlet weak var moviesPoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        }
    }
    
    @IBOutlet weak var launchYearLabel: UILabel! {
        didSet {
            self.launchYearLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        }
    }
    
    @IBOutlet weak var genresLabel: UILabel! {
        didSet {
            self.genresLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        }
    }
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView! {
        didSet {
            self.imageActivityIndicator.hidesWhenStopped = true
            self.imageActivityIndicator.startAnimating()
        }
    }
    
    func setUpCell(movie: Movie) {
        self.titleLabel.text = movie.title
        self.launchYearLabel.text = movie.releaseDate
        for gender in movie.genres {
           self.genders += gender
        }
        self.genresLabel.text = self.genders
        if let image = movie.image {
            self.moviesPoster.image = image
        } else {
            self.moviesPoster.image = UIImage(named: "movie_placeholder")
        }
        self.imageActivityIndicator.stopAnimating()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
