//
//  MoviesTableViewCell.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 04/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    

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
        var genders: String = ""
        self.titleLabel.text = movie.title
        self.launchYearLabel.text = movie.releaseDate
        for gender in movie.genres {
            //Tratamento para não inserir gêneros repetidos
            if (!genders.contains(gender)) {
                genders += gender
                genders += ", "
            }
        }
        genders = String(genders.dropLast(2))
        self.genresLabel.text = genders
        if let image = movie.image {
            self.moviesPoster.image = image
        } else {
            self.moviesPoster.image = UIImage(named: "movie_placeholder")
        }
        self.imageActivityIndicator.stopAnimating()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
