//
//  MovieWithDetailsViewController.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 05/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import UIKit

class MovieWithDetailsViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var moviePosterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
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
    
    @IBOutlet weak var originalTitleLabel: UILabel! {
        didSet {
            self.originalTitleLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    
    @IBOutlet weak var originalLanguageLabel: UILabel! {
        didSet {
            self.originalLanguageLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        }
    }
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var moviesWithDetailsActivityIndicator: UIActivityIndicatorView! {
        didSet {
            self.moviesWithDetailsActivityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var noInternetView: UIView! {
        didSet {
            self.noInternetView.isHidden = true
        }
    }
    @IBOutlet weak var moviesDetailScrollView: UIScrollView!
    
    //MARK: - Variables
    var movie: MovieWithDetails? = nil
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
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    func getDetails() {
        self.moviesWithDetailsActivityIndicator.startAnimating()
        self.noInternetView.isHidden = true
        self.moviesDetailScrollView.isScrollEnabled = true
        AlamofireService.getMovieWithDetails(movieId: self.id) { (movieWithDetails) in
            guard let movieDetails = movieWithDetails else {
                self.noInternetView.isHidden = false
                self.moviesDetailScrollView.isScrollEnabled = false
                return
            }
            self.titleLabel.text = self.title
            self.overviewLabel.text = movieDetails.overview
            self.revenueLabel.text = "Revenue: \(self.currencyFormatter.string(from: NSNumber(value: movieDetails.revenue)) ?? "")"
            self.runtimeLabel.text = "Runtime: \(movieDetails.runtime.description) Minutes"
            self.languagesLabel.text = "Languages: " + movieDetails.spokenLanguages.joined(separator: ", ")
            self.originalTitleLabel.text = "Original title: \(movieDetails.originalTitle)"
            self.originalLanguageLabel.text = "Original language: \(movieDetails.originalLanguage)"
            self.moviesWithDetailsActivityIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }

    @objc func internetConnected() {
       getDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviePosterView.image = self.moviePoster
        self.yearLabel.text = "Launch Year: \(self.year.prefix(4))"
        self.genresLabel.text = "Gêneros: " + self.genres.joined(separator: ", ")
        NotificationCenter.default.addObserver(self, selector: #selector(internetConnected), name: .InternetConnected, object: nil)
        self.getDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .InternetConnected, object: nil)
    }
}
