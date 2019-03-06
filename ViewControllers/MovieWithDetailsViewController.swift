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

    @IBOutlet weak var moviePosterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = self.title
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        }
    }
    
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            self.yearLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    
    @IBOutlet weak var genresLabel: UILabel! {
        didSet {
            self.genresLabel.font = UIFont.preferredFont(forTextStyle: .callout)
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
    lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    func getDetails() {
        AlamofireService.getMovieWithDetails(movieId: self.id) { (movieWithDetails) in
            guard let movieDetails = movieWithDetails else {
                self.overviewLabel.text = "nao conectado"
                return
            }
            self.overviewLabel.text = movieDetails.overview
            self.revenueLabel.text = "Receita: \(self.currencyFormatter.string(from: NSNumber(value: movieDetails.revenue)) ?? "")"
            self.runtimeLabel.text = "Duração: \(movieDetails.runtime.description)"
            self.languagesLabel.text = "Linguagens: " + movieDetails.spokenLanguages.joined(separator: ", ")
        }
    }

    @objc func internetConnected() {
       getDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(internetConnected), name: .InternetConnected, object: nil)
        self.moviePosterView.image = self.moviePoster
        self.yearLabel.text = "Data de lançamento: " + self.year
        self.genresLabel.text = "Gêneros: " + self.genres.joined(separator: ", ")
        self.getDetails()
    }
}
