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
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Melhores filmes do TMDB"
        NotificationCenter.default.addObserver(self, selector: #selector(moviesDownloaded(notification:)), name:.MoviesDownloaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moviePosterDownloaded(notification:)), name: .ImageDownloaded, object: nil)
        self.mainActivityIndicator.startAnimating()
        AlamofireService.getMovies { (moviesArray) in
            self.movies = moviesArray
            NotificationCenter.default.post(Notification(name: .MoviesDownloaded))
        }
    }
    
    // MARK: - Methods
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
        self.mainActivityIndicator.stopAnimating()
        self.moviesTableView.reloadData()
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
    
}
