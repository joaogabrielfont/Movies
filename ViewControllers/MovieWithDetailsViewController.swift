//
//  MovieWithDetailsViewController.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 05/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import UIKit

class MovieWithDetailsViewController: UIViewController {
    
    var movie: MovieWithDetails? = nil

    @IBOutlet weak var moviePosterView: UIImageView! {
        didSet {
            self.moviePosterView.image = self.moviePoster
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = self.title
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        }
    }
    
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            self.yearLabel.font = UIFont.preferredFont(forTextStyle: .callout)
            self.yearLabel.text = "Data de lançamento: " + self.year
        }
    }
    
    @IBOutlet weak var genresLabel: UILabel! {
        didSet {
            self.genresLabel.font = UIFont.preferredFont(forTextStyle: .callout)
            var genres: String = ""
            for genre in self.genres {
                if !genres.contains(genre) {
                    genres += genre
                    genres += ", "
                }
            }
            genres = String(genres.dropLast(2))
            self.genresLabel.text = "Gêneros: " + genres
        }
    }
    
    @IBOutlet weak var overviewLabel: UILabel! {
        didSet {
            self.overviewLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        }
    }
    
    @IBOutlet weak var runtimeLabel: UILabel! {
        didSet {
            self.runtimeLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    
    @IBOutlet weak var revenueLabel: UILabel! {
        didSet {
            self.revenueLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    
    @IBOutlet weak var languagesLabel: UILabel! {
        didSet {
            self.languagesLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    
    var id: Int = 0
    var movieTitle: String = ""
    var moviePoster: UIImage? = nil
    var genres: [String] = []
    var year: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlamofireService.getMovieWithDetails(movieId: self.id) { (movieWithDetails) in
            self.overviewLabel.text = movieWithDetails?.overview
            self.revenueLabel.text = movieWithDetails?.revenue.description
            self.runtimeLabel.text = movieWithDetails?.runtime.description
        }
    }
}
