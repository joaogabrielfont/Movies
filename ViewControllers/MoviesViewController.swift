//
//  MoviesViewController.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 04/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            self.moviesTableView.isHidden = true
            self.moviesTableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: String(describing: MoviesTableViewCell.self))
            self.moviesTableView.register(UINib(nibName: String(describing: MoviesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MoviesTableViewCell.self))
            self.moviesTableView.delegate = self
            self.moviesTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView! {
        didSet {
            self.mainActivityIndicator.hidesWhenStopped = true
        }
    }

    @IBOutlet weak var emptyStateView: UIView! {
        didSet {
            self.emptyStateView.isHidden = true
        }
    }


    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Melhores filmes do TMDB"
        NotificationCenter.default.addObserver(self, selector: #selector(moviesDownloaded(notification:)), name:.MoviesDownloaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moviePosterDownloaded(notification:)), name: .ImageDownloaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(internetConnected), name: .InternetConnected, object: nil)
        self.getMovies()
    }
    
    // MARK: - Methods
    func getMovies() {
        print("remove empty state")
        self.emptyStateView.isHidden = true
        self.mainActivityIndicator.startAnimating()
        AlamofireService.getMovies { (moviesArray) in
            self.mainActivityIndicator.stopAnimating()
            self.movies = moviesArray
            if moviesArray.isEmpty {
                print("empty state")
                self.emptyStateView.isHidden = false
            } else {
                NotificationCenter.default.post(Notification(name: .MoviesDownloaded))
            }
        }
    }

    @objc func moviePosterDownloaded(notification: Notification) {
        guard let userInfo = notification.userInfo, let movieId = userInfo[NotificationKeys.movieId] as? Int else {
            return
        }
        if let index = self.movies.index(where: { (movie) -> Bool in return movie.id == movieId}) {
            self.moviesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    @objc func moviesDownloaded(notification: Notification) {
        self.moviesTableView.isHidden = false
        self.moviesTableView.reloadData()
    }

    @objc func internetConnected() {
        if self.movies.isEmpty {
            self.getMovies()
        }
    }
}

//MARK: - TableView DataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = moviesTableView.dequeueReusableCell(withIdentifier: String(describing: MoviesTableViewCell.self), for: indexPath) as? MoviesTableViewCell {
            cell.setUpCell(movie: self.movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "MovieWithDetailsViewController") as? MovieWithDetailsViewController{
            vc.title = self.movies[indexPath.row].title
            vc.year = self.movies[indexPath.row].releaseDate
            vc.moviePoster = self.movies[indexPath.row].image
            vc.genres = self.movies[indexPath.row].genres
            vc.id = self.movies[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
